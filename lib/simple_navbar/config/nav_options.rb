module SimpleNavbar
  module Config
    class NavOptions
      attr_accessor :name, :url, :html
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

      def html
        @options[:html]
      end
    end
  end
end
