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

    group = navbar.css('.group')
    group.should_not == nil

    title = group.css('.title')
    title.should_not == nil

    items = group.css('.items')
    items.should_not == nil

    item_dash = items.css('.item.dashboard')
    item_dash.should_not == nil

    item_homeworks = items.css('.item.homeworks')
    item_homeworks.should_not == nil

    item_media_resources = items.css('.item.media_resources')
    item_media_resources.should_not == nil

    subitems = item_media_resources.css('subitems')
    subitems.should_not == nil

    subitem_my_resources = subitems.css('.subitem.my_resources')
    subitem_my_resources.should_not == nil

    subitem_media_shares = subitems.css('.subitem.media_shares')
    subitem_media_shares.should_not == nil

    subitem_public_resources = subitems.css('.subitem.public_resources')
    subitem_public_resources.should_not == nil
     
  end
end