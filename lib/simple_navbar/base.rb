module SimpleNavbar
  class Base
    ## parse config build html ##
    def self.render_sidebar(view, rule_sym)
      html = "<div class='page-navbar'>"

      SimpleNavbar::Rule.get(rule_sym).groups.each do |group|
        html << render_group(view, group)
      end
      
      html << "</div>"
      view.raw(html)
    end

    def self.render_group(view, group)
      html = "<div class='group'>"
      html << "<div class='title'>#{group.options[:name]}</div>"
      html << "<div class='items'>"

      group.navs.each do |nav|
        html << render_nav(view,nav)
      end

      html << "</div>"
      html << "</div>"
      html
    end

    def self.render_nav(view, nav)
      klass = nav.is_current?(view) ? "item current" : "item"
      nav_html = "<div class='#{klass} #{nav.title}'>"
      nav_html << "<a href='#{nav.options[:url]}' class='lv1'>#{nav.options[:name]}</a>"
      nav_html << render_subnavs(view, nav)
      nav_html << "</div>"

      nav_html
    end

    def self.render_subnavs(view, nav)
      return "" if nav.subnavs.blank?

      nav_html = "<div class='subitems'>"
      nav.subnavs.each do |subnav|
        klass = subnav.is_current?(view) ? "subitem current" : "subitem"
        nav_html << "<div class='#{klass} #{subnav.title}'>"
        nav_html << "<a href='#{subnav.options[:url]}' class='lv2'>#{subnav.options[:name]}</a>"
        nav_html << "</div>"
      end
      nav_html << "</div>"

      nav_html
    end
    ## parse config build html ##

    ######## config DSL #########
    def self.config(&block)
      SimpleNavbar::Rule.init
      self.instance_eval(&block)
    end

    def self.rule(rule_syms, &block)
      rules = [rule_syms].flatten.map{|rule_sym| SimpleNavbar::Rule.get(rule_sym)}

      SimpleNavbar::CurrentContext.instance.rules = rules
      self.instance_eval(&block)
      SimpleNavbar::CurrentContext.instance.rules = nil
    end

    def self.group(title, options, &block)
      group = SimpleNavbar::Group.new(title, options)
      SimpleNavbar::CurrentContext.instance.group = group

      self.instance_eval(&block)
      SimpleNavbar::CurrentContext.instance.rules.each do |rule|
        rule.groups << group
      end

      SimpleNavbar::CurrentContext.instance.group = nil
    end

    def self.nav(title, options, &block)
      nav = SimpleNavbar::Nav.new(title, options)
      SimpleNavbar::CurrentContext.instance.nav = nav

      self.instance_eval(&block)
      SimpleNavbar::CurrentContext.instance.group.navs << nav

      SimpleNavbar::CurrentContext.instance.nav = nil
    end

    def self.subnav(title, options, &block)
      nav = SimpleNavbar::Nav.new(title, options)
      SimpleNavbar::CurrentContext.instance.subnav = nav

      self.instance_eval(&block)
      SimpleNavbar::CurrentContext.instance.nav.subnavs << nav

      SimpleNavbar::CurrentContext.instance.subnav = nil
    end

    def self.controller(controller_name, options = {})
      item = SimpleNavbar::ControllerItem.new(controller_name, options)
      context = SimpleNavbar::CurrentContext.instance
      nav = context.subnav || context.nav
      nav.controller_items << item
    end
    ######## config DSL #########
  end
end