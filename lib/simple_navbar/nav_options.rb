# -*- encoding : utf-8 -*-
module SimpleNavbar
  class NavOptions
    attr_accessor :name, :url
    def initialize(nav, options)
      @nav = nav
      @options = options
    end

    def url
      @options[:url]
    end

    def name
      @options[:name] || I18n.t("simple-navbar.#{@nav.rule.title}.#{@nav.title}")
    end
  end
end