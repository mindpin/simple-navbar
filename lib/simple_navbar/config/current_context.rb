require 'singleton'

module SimpleNavbar
  module Config
    class CurrentContext
      attr_accessor :rules, :nav
      include Singleton
    end
  end
end
