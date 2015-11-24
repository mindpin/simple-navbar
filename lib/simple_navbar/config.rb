require 'simple_navbar/config/rule'
require 'simple_navbar/config/current_context'
require 'simple_navbar/config/nav'
require 'simple_navbar/config/nav_options'
require 'simple_navbar/config/controller_item'
require 'simple_navbar/config/error'

# -*- encoding : utf-8 -*-
module SimpleNavbar
  module Config
    def config(&block)
      SimpleNavbar::Config::Rule.init
      self.instance_eval(&block)
    end

    def rule(rule_syms, &block)
      rules = [rule_syms].flatten.map{|rule_sym| SimpleNavbar::Config::Rule.get_or_create(rule_sym)}

      SimpleNavbar::Config::CurrentContext.instance.rules = rules
      self.instance_eval(&block)
      SimpleNavbar::Config::CurrentContext.instance.rules = nil
    end

    def nav(title, options, &block)
      new_nav = SimpleNavbar::Config::Nav.new(title, options)
      parent_nav = SimpleNavbar::Config::CurrentContext.instance.nav
      new_nav.set_parent(parent_nav)
      SimpleNavbar::Config::CurrentContext.instance.nav = new_nav

      self.instance_eval(&block)

      SimpleNavbar::Config::CurrentContext.instance.nav = parent_nav

      if parent_nav.blank?
        SimpleNavbar::Config::CurrentContext.instance.rules.each do |rule|
          new_nav.set_rule(rule)
        end
      end

    end

    def controller(controller_name, options = {})
      item = SimpleNavbar::Config::ControllerItem.new(controller_name, options)
      context = SimpleNavbar::Config::CurrentContext.instance
      nav = context.nav
      nav.controller_items << item
    end
  end
end
