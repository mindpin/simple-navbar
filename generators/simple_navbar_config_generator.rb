# -*- encoding : utf-8 -*-
class SimpleNavbarConfigGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  def create_simple_navbar_config_file
    template "simple_navbar_config.rb", "config/simple_navbar_config.rb"
  end
end
