module SimpleNavbar
  module Helpers
    module SimpleNavtabsHelper
      def simple_navtabs(rule)
        rule    = SimpleNavbar::Config::Rule.get(rule.to_sym)
        navtabs = SimpleNavbar::Render::SimpleNavtabs::Navtabs.new(self, rule)

        capture_haml do
          navtabs.render
        end
      end
    end
  end
end
