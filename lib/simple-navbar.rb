require 'simple_navbar/config'
require 'simple_navbar/render'
require 'simple_navbar/helpers'
require 'simple_navbar/base'

if defined?(Rails)

  module SimpleNavbar
    class Railtie < Rails::Railtie

      initializer 'SimpleNavbar.helper' do |app|
        SimpleNavbar::Base.include_helper
      end

      config.to_prepare do
        filename = File.join(Rails.root.to_s, 'config/simple_navbar_config.rb')
        load filename if File.exists?(filename)
      end

      generators do
        require File.expand_path("../../generators/simple_navbar_config_generator", __FILE__)
      end

      initializer 'SimpleNavbar.assets.precompile' do |app|
        path = File.expand_path("../../", __FILE__)
        %w(stylesheets).each do |sub|
          app.config.assets.paths << File.join(path, 'assets', sub).to_s
        end
      end

    end
  end

end
