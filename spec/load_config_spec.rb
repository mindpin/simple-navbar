require 'spec_helper'


describe "读取配置相关" do
  it '错误提示' do
    view = View.new

    expect { 
      view.simple_navbar(:teacher)
    }.to raise_error(SimpleNavbar::UnconfigurationError)

    require 'config/simple_navbar_config'

    expect {
      view.simple_navbar(:a)
    }.to raise_error(SimpleNavbar::UndefinedRuleError)

    view.simple_navbar(:teacher)
  end

  it 'simple_navbar 输出 html' do
    view = View.new
    require 'config/simple_navbar_config'

    html_str = view.simple_navbar(:teacher)

    navbar = Nokogiri::XML(html_str).css('.page-navbar')
    navbar.should_not == nil

    group = navbar.at_css('.group')
    group.should_not == nil

    title = group.at_css('.title')
    title.should_not == nil

    items = group.at_css('.items')
    items.should_not == nil

    item_dash = items.at_css('.item.dashboard')
    item_dash.should_not == nil

    item_homeworks = items.at_css('.item.homeworks')
    item_homeworks.should_not == nil

    item_media_resources = items.at_css('.item.media_resources')
    item_media_resources.should_not == nil

    subitems = item_media_resources.at_css('.subitems')
    subitems.should_not == nil

    subitem_my_resources = subitems.at_css('.subitem.my_resources')
    subitem_my_resources.should_not == nil

    subitem_media_shares = subitems.at_css('.subitem.media_shares')
    subitem_media_shares.should_not == nil

    subitem_public_resources = subitems.at_css('.subitem.public_resources')
    subitem_public_resources.should_not == nil
     
  end
end