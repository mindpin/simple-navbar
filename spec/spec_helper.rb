require 'rails'
require 'active_support/core_ext'
require 'action_view'
require 'haml'
require 'simple-navbar'
require 'nokogiri'

ActionView::Base.send(:include, SimpleNavbar::Helpers)
view = ActionView::Base.new
class << view
  include Haml::Helpers
end
view.init_haml_helpers

def view.params
  {
    "controller" => "index",
    "action"     => "index"
  }
end
MOCK_VIEW = view

