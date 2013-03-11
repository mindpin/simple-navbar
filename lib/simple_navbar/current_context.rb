require 'singleton'

module SimpleNavbar
  class CurrentContext
    attr_accessor :rules, :group, :nav
    include Singleton
  end
end