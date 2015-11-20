# -*- encoding : utf-8 -*-
module SimpleNavbar
  module SimpleNavtabsHelpers
    def simple_navtabs(rule)
      rule    = SimpleNavbar::Rule.get(rule.to_sym)
      navtabs = SimpleNavbar::Render::Navtabs.new(self, rule)

      capture_haml do
        navtabs.render
      end
    end

  end
end
