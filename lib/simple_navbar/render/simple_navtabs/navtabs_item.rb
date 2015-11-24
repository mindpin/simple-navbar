module SimpleNavbar
  module Render
    module SimpleNavtabs
      class NavtabsItem

        def initialize(view, text, url, controller_items)
          @view = view
          @text = text
          @url  = url

          @controller_items = controller_items
        end

        def is_active?
          controller = @view.params["controller"].to_sym
          action = @view.params["action"].to_sym

          @controller_items.each do |item|
            return true if item.is_current?(controller, action)
          end

          return false
        end

        def render
          attrs = {:role => "presentation"}
          attrs[:class] = "active" if is_active?

          @view.haml_tag :li, attrs do
            @view.haml_tag :a, @text,:href => @url
          end
        end

      end
    end
  end
end
