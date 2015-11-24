module SimpleNavbar
  module Render
    module SimpleNavbar
      module Base
        class Navbar
          attr_accessor :view, :items

          def initialize(view, options = {})
            @view = view
            @items = []

            @ul_class = options[:ul_class] || "nav"
            @class    = options[:class]    || "simple_navbar"
          end

          def add_item_obj(item)
            item.parent = self
            item.view = @view
            item.ul_class = @ul_class
            @items << item
            self
          end

          def render
            @view.haml_tag :div, :class => @class do
              _render_ul
            end
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
