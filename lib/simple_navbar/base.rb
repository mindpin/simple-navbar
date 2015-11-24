module SimpleNavbar
  class Base
    extend SimpleNavbar::Config

    def self.include_helper
      ActionView::Base.send :include, SimpleNavbar::Helpers::SimpleNavbarHelper
      ActionView::Base.send :include, SimpleNavbar::Helpers::SimpleBreadcrumbsHelper
      ActionView::Base.send :include, SimpleNavbar::Helpers::SimpleNavtabsHelper
      ActionView::Base.send :include, SimpleNavbar::Helpers::QuickFilterBarHelper
    end
  end
end
