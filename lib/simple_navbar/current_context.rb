# -*- encoding : utf-8 -*-
require 'singleton'

module SimpleNavbar
  class CurrentContext
    attr_accessor :rules, :nav
    include Singleton
  end
end
