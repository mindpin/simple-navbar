module SimpleNavbar
  module Render
    class Navtabs
      def initialize(view, rule)
        @view = view
        @rule = rule
      end

      def navtabs_items
        @rule.navs.map do |nav|
          text = nav.options.name
          url  = nav.options.url
          controller_items = nav.controller_items
          SimpleNavbar::Render::NavtabsItem.new(@view, text, url, controller_items)
        end
      end

      def render
        @view.haml_tag :ul, :class => 'nav nav-tabs' do
          navtabs_items.each do |item|
            item.render
          end
        end
      end
    end
  end
end
