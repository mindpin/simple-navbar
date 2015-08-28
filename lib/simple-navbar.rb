# -*- encoding : utf-8 -*-
require 'simple-page-compoents'
require 'simple_navbar/config'
require 'simple_navbar/controller_item'
require 'simple_navbar/current_context'
require 'simple_navbar/simple_navbar_helpers'
require 'simple_navbar/simple_breadcrumbs_helper'
require 'simple_navbar/nav_options'
require 'simple_navbar/nav'
require 'simple_navbar/rule'
require 'simple_navbar/error'
require 'simple_navbar/render/nav_item'

module SimpleNavbar
  class Base
    extend SimpleNavbar::Config
  end
end

if defined?(Rails)

  module SimpleNavbar
    class Railtie < Rails::Railtie

      initializer 'SimpleNavbar.helper' do |app|
        ActionView::Base.send :include, SimpleNavbar::SimpleNavbarHelpers
        ActionView::Base.send :include, SimpleNavbar::SimpleBreadcrumbsHelpers
      end

      config.to_prepare do
        filename = File.join(Rails.root.to_s, 'config/simple_navbar_config.rb')
        load filename if File.exists?(filename)
      end

      generators do
        require File.expand_path("../../generators/simple_navbar_config_generator", __FILE__)
      end

    end
  end

end
