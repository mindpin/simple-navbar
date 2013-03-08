module SimpleNavbar
  module Helpers
    def simple_navbar(rule)
      SimpleNavbar::Base.render_sidebar(self, rule)
    end
  end
end