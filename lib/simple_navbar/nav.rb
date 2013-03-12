# -*- encoding : utf-8 -*-
module SimpleNavbar
  class Nav
    attr_accessor :title, :options, :controller_items, :subnavs, :parent
    def initialize(title, options)
      self.title = title
      self.options = options
      self.controller_items = []
      self.subnavs = []
    end

    def set_parent(parent)
      return if parent.blank?
      self.parent = parent
      parent.subnavs << self
    end

  end
end
