module SimpleNavbar
  module Render
    module SimpleNavbar
      module Base
        class NavItem
          attr_accessor :controller_items
          attr_accessor :text, :url
          attr_accessor :parent, :view
          attr_accessor :items
          attr_accessor :ul_class

          def initialize(text, url, options = {})
            @option_class     = options[:class] || ''
            @controller_items = options[:controller_items]

            @parent = nil
            @view   = nil

            @text = text
            @url  = url

            @items = []
          end

          def css_class
            c = [@option_class]
            c << 'active' if is_active?

            re = c.join(' ')

            re.blank? ? nil : re
          end

          def add_item_obj(item)
            item.parent = self
            item.view = @view
            item.ul_class = @ul_class
            @items << item
            self
          end

          def is_active?
            controller = @view.params["controller"].to_sym
            action = @view.params["action"].to_sym

            self.controller_items.each do |item|
              return true if item.is_current?(controller, action)
            end

            @items.each do |nav|
              return true if nav.is_active?
            end

            return false
          end

          def render
            @view.haml_tag :li, :class => self.css_class do
              _render_a
              _render_ul
            end
          end


          private
            def _render_a
              @view.haml_tag :a, @text,:href => @url
            end

            def _render_ul
              @view.haml_tag :ul, :class => @ul_class do
                @items.each { |item| item.render }
              end if @items.present?
            end

        end

      end
    end
  end
end
