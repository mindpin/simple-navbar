module SimpleNavbar
  module Helpers
    module SimpleBreadcrumbsHelper
      def simple_breadcrumbs(rule, &block)
        cb = CustomBreadcrumbs.new
        cb.instance_eval(&block) if !block.blank?

        @current_nav_item = nil
        rule = SimpleNavbar::Config::Rule.get(rule.to_sym)
        rule.navs.each do |nav|
          _recursion_nav(nil, nav)
        end

        actives_nav_items = _get_actives_nav_items_by_current_nav_item
        breadcrumbs = actives_nav_items.map{|item|[item.text,item.url]}

        breadcrumbs += cb.custom_breadcrumbs

        capture_haml do
          _render_breadcrumbs breadcrumbs
        end

      end

      private

      # <ol class="breadcrumb">
      #   <li><a href="#">Home</a></li>
      #   <li><a href="#">Library</a></li>
      #   <li class="active">Data</li>
      # </ol>
      def _render_breadcrumbs(breadcrumbs)
        self.haml_tag :ol, :class => 'breadcrumb' do
          count = breadcrumbs.count
          breadcrumbs.each_with_index do |breadcrumb, index|
            if index+1 == count
              self.haml_tag :li, breadcrumb[0], :class => "active"
              next
            end

            self.haml_tag :li do
              self.haml_tag :a, breadcrumb[0], :href => breadcrumb[1]
            end

          end
        end
      end

      def _get_actives_nav_items_by_current_nav_item
        return [] if @current_nav_item.blank?

        actives_nav_items = [@current_nav_item]

        parent = @current_nav_item.parent
        while !parent.blank? do
          actives_nav_items.unshift(parent)
          parent = parent.parent
        end
        actives_nav_items
      end

      def _recursion_nav(parent_nav_item, nav)
        nav_item = _convert_nav_to_nav_item(nav)

        if !parent_nav_item.blank?
          parent_nav_item.add_item_obj nav_item
        else
          nav_item.view = self
        end
        @current_nav_item = nav_item if nav_item.is_active?

        nav.subnavs.each do |subnav|
          _recursion_nav(nav_item, subnav)
        end
      end

      def _convert_nav_to_nav_item(nav)
        name = nav.options.name
        url  = nav.options.url
        nav_item = ::SimpleNavbar::Render::SimpleNavbar::Base::NavItem.new(name, url, :class => nav.title)
        nav_item.controller_items = nav.controller_items
        nav_item
      end

      class CustomBreadcrumbs
        def add(name, url)
          @custom_breadcrumbs ||= []
          @custom_breadcrumbs << [name, url]
        end

        def custom_breadcrumbs
          @custom_breadcrumbs ||= []
        end
      end


    end

  end
end
