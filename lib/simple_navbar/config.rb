module SimpleNavbar
  module Config
    def config(&block)
      SimpleNavbar::Rule.init
      self.instance_eval(&block)
    end

    def rule(rule_syms, &block)
      rules = [rule_syms].flatten.map{|rule_sym| SimpleNavbar::Rule.get_or_create(rule_sym)}

      SimpleNavbar::CurrentContext.instance.rules = rules
      self.instance_eval(&block)
      SimpleNavbar::CurrentContext.instance.rules = nil
    end

    def group(title, options, &block)
      group = SimpleNavbar::Group.new(title, options)
      SimpleNavbar::CurrentContext.instance.group = group

      self.instance_eval(&block)
      SimpleNavbar::CurrentContext.instance.rules.each do |rule|
        rule.groups << group
      end

      SimpleNavbar::CurrentContext.instance.group = nil
    end

    def nav(title, options, &block)
      new_nav = SimpleNavbar::Nav.new(title, options)
      parent_nav = SimpleNavbar::CurrentContext.instance.nav
      new_nav.set_parent(parent_nav)
      SimpleNavbar::CurrentContext.instance.nav = new_nav

      self.instance_eval(&block)

      SimpleNavbar::CurrentContext.instance.nav = parent_nav

      if parent_nav.blank?
        SimpleNavbar::CurrentContext.instance.group.navs << new_nav
      end

    end

    def controller(controller_name, options = {})
      item = SimpleNavbar::ControllerItem.new(controller_name, options)
      context = SimpleNavbar::CurrentContext.instance
      nav = context.subnav || context.nav
      nav.controller_items << item
    end
  end
end