# -*- encoding : utf-8 -*-
module SimpleNavbar
  module Helpers
    def simple_navbar(rule, *args)
      navbar = SimplePageCompoents::NavbarRender.new(self, *args)

      rule = SimpleNavbar::Rule.get(rule.to_sym)
      rule.navs.each do |nav|
        _xxx_r(navbar, nav)
      end

      capture_haml do
        navbar.render
      end
    end

    private

    def _xxx_r(navbar_or_item, nav)
      item = _convert(nav)
      navbar_or_item.add_item_obj item

      nav.subnavs.each do |subnav|
        _xxx_r(item, subnav)
      end
    end
    
    def _convert(nav)
      name = nav.options.name
      url  = nav.options.url
      nav_item = SimpleNavbar::Render::NavItem.new(name, url, :class => nav.title)
      nav_item.controller_items = nav.controller_items
      nav_item
    end

  end
end
