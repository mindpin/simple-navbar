require 'simple_navbar/base'
require 'simple_navbar/controller_item'
require 'simple_navbar/current_context'
require 'simple_navbar/group'
require 'simple_navbar/helpers'
require 'simple_navbar/nav'
require 'simple_navbar/rule'
require 'simple_navbar/error'

if defined?(Rails)

  module SimpleNavbar
    class Railtie < Rails::Railtie

      initializer 'SimpleNavbar.helper' do |app|
        ActionView::Base.send :include, SimpleNavbar::Helpers
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
