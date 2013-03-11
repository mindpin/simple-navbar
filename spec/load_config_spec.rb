require 'spec_helper'


describe "读取配置相关" do
  it '错误提示' do
    view = View.new

    expect { 
      view.simple_navbar(:admin)
    }.to raise_error(SimpleNavbar::UnconfigurationError)

    require 'config/simple_navbar_config'

    expect {
      view.simple_navbar(:a)
    }.to raise_error(SimpleNavbar::UndefinedRuleError)

    view.simple_navbar(:admin)
  end

  it 'simple' do
    rule = SimpleNavbar::Rule.get(:simple)
    rule.title.should == :simple

    groups = rule.groups
    groups.length.should == 1

    group = groups[0]
    group.title.should == :default
    navs = group.navs
    navs.length.should == 4

    index_nav = navs[0]
    index_nav.title.should == :index
    index_nav.options[:url].should == '/'
    index_nav.options[:name].should == '首页'
    controller_items = index_nav.controller_items
    controller_items.length.should == 1
    controller_item = controller_items[0]
    controller_item.controller_name.should == :index

    books_nav = navs[1]
    books_nav.title.should == :books
    movies_nav = navs[2]
    movies_nav.title.should == :movies
    musics_nav = navs[3]
    musics_nav.title.should == :musics
  end

  it 'multi_level_example' do
    rule = SimpleNavbar::Rule.get(:multi_level_example)
    rule.title.should == :multi_level_example
    
    groups = rule.groups
    groups.length.should == 1

    group = groups[0]
    group.title.should == :default
    navs = group.navs
    navs.length.should == 3

    musics_nav = navs[2]
    controller_items = musics_nav.controller_items
    controller_items.length.should == 4
    controller_items[0].controller_name.should == :musics
    controller_items[1].controller_name.should == :pop_musics
    controller_items[2].controller_name.should == :rock_musics
    controller_items[3].controller_name.should == :punk_musics 

    musics_nav.subnavs.length.should == 1
    pop_nav = musics_nav.subnavs[0]
    controller_items = pop_nav.controller_items
    controller_items.length == 3
    controller_items[0].controller_name.should == :pop_musics
    controller_items[1].controller_name.should == :rock_musics
    controller_items[2].controller_name.should == :punk_musics 

    pop_nav.subnavs.length.should == 1
    rock_nav = pop_nav.subnavs[0]
    controller_items = rock_nav.controller_items
    controller_items.length == 2
    controller_items[0].controller_name.should == :rock_musics
    controller_items[1].controller_name.should == :punk_musics

    rock_nav.subnavs.length.should == 1
    punk_nav = rock_nav.subnavs[0]
    controller_items = punk_nav.controller_items
    controller_items.length == 1
    controller_items[0].controller_name.should == :punk_musics
    

  end

  it 'mutil_rule' do
    rule_1 = SimpleNavbar::Rule.get(:rule_1)
    rule_1.title.should == :rule_1

    rule_2 = SimpleNavbar::Rule.get(:rule_1)
    rule_2.title.should == :rule_1

    rule_1.groups.length.should == 1
    rule_1.groups.length.should == rule_2.groups.length
    rule_1.groups[0].navs.length == 4
    rule_1.groups[0].navs.length == rule_2.groups[0].navs.length
  end

  it 'admin' do
    rule_admin = SimpleNavbar::Rule.get(:admin)
    rule_admin.title.should == :admin
    rule_admin.groups.length.should == 2
    rule_admin.groups[0].navs.length == 1
    nav = rule_admin.groups[0].navs[0]

    nav.title.should == :index
    nav.controller_items.length == 1
    nav.controller_items[0].controller_name.should == :'admin/index'
  end

  it 'simple 输出 html' do
    view = View.new

    html_str = view.simple_navbar(:simple)

    navbar = Nokogiri::XML(html_str).css('.page-navbar')
    navbar.should_not == nil

    group = navbar.at_css('.group')
    group.should_not == nil

    title = group.at_css('.title')
    title.should_not == nil

    items = group.at_css('.items')
    items.should_not == nil

    item_index = items.at_css('.item.index')
    item_index.should_not == nil

    item_books = items.at_css('.item.books')
    item_books.should_not == nil

    item_movies = items.at_css('.item.movies')
    item_movies.should_not == nil
    
    item_musics = items.at_css('.item.musics')
    item_musics.should_not == nil
    
  end
end