module SimpleNavbar
  module Helpers
    module SimpleNavbarHelper
      def simple_navbar(rule, options = {})
        if !options[:mode].blank? && options[:mode].to_sym == :bootstrap
          if !options[:ul_class].blank?
            options[:ul_class] = "#{options[:ul_class]} nav navbar-nav"
          else
            options[:ul_class] = "nav navbar-nav"
          end

          if !options[:class].blank?
            options[:class] = "#{options[:class]} collapse navbar-collapse"
          else
            options[:class] = "collapse navbar-collapse"
          end

          navbar = ::SimpleNavbar::Render::SimpleNavbar::Base::Navbar.new(self, options)
        else
          navbar = ::SimpleNavbar::Render::SimpleNavbar::DefaultNavbar.new(self, options)
        end

        rule = SimpleNavbar::Config::Rule.get(rule.to_sym)
        rule.navs.each do |nav|
          _recursive_convert(navbar, nav)
        end

        capture_haml do
          navbar.render
        end
      end

      private

      def _recursive_convert(navbar_or_item, nav)
        item = SimpleNavbar::Render::SimpleNavbar::Base::NavItem.new(
          nav.options.name,
          nav.options.url,
          :class => nav.title,
          :controller_items => nav.controller_items,
          :html  => nav.options.html
        )

        navbar_or_item.add_item_obj item

        nav.subnavs.each do |subnav|
          _recursive_convert(item, subnav)
        end
      end

    end

  end
end
