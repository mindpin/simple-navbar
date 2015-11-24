module SimpleNavbar
  module Render
    module SimpleNavbar
      class DefaultNavbar < Base::Navbar
        def css_class
          'page-navbar'
        end

        def inner_css_class
          'navbar-inner'
        end

        def render
          @view.haml_tag :div, :class => self.css_class do
            @view.haml_tag :div, :class => self.inner_css_class do
              _render_ul
            end
          end
        end

      end
    end
  end
end
