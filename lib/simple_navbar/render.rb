module SimpleNavbar
  module Render
    def render_sidebar(view, rule_sym)
      html = "<div class='page-navbar'>"
      html << "<div class='items'>"
      SimpleNavbar::Rule.get(rule_sym).navs.each do |nav|
        html << render_nav(view,nav)
      end
      html << "</div>"
      html << "</div>"
      view.raw(html)
    end

    def render_nav(view, nav)
      klass = nav.is_current?(view) ? "item current" : "item"
      nav_html = "<div class='#{klass} #{nav.title}'>"
      nav_html << "<a href='#{nav.options[:url]}' class='lv1'>#{nav.options[:name]}</a>"
      nav_html << render_subnavs(view, nav)
      nav_html << "</div>"

      nav_html
    end

    def render_subnavs(view, nav)
      return "" if nav.subnavs.blank?

      nav_html = "<div class='subitems'>"
      nav.subnavs.each do |subnav|
        klass = subnav.is_current?(view) ? "subitem current" : "subitem"
        nav_html << "<div class='#{klass} #{subnav.title}'>"
        nav_html << "<a href='#{subnav.options[:url]}' class='lv2'>#{subnav.options[:name]}</a>"
        nav_html << render_subnavs(view, subnav)
        nav_html << "</div>"
      end
      nav_html << "</div>"

      nav_html
    end
  end
end