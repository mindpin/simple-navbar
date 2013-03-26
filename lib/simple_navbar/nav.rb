# -*- encoding : utf-8 -*-
module SimpleNavbar
  class Nav
    attr_accessor :title, :controller_items, :subnavs, :parent
    def initialize(title, options)
      self.title = title
      @options = options
      self.controller_items = []
      self.subnavs = []
    end

    def set_parent(parent)
      return if parent.blank?
      self.parent = parent
      parent.subnavs << self
    end

    def set_rule(rule)
      return if rule.blank?
      rule.navs << self
      @rule = rule
    end

    def rule
      @rule || self.parent.rule
    end

    def options
      NavOptions.new(self, @options)
    end

  end
end
