# -*- encoding : utf-8 -*-
require 'spec_helper'


describe "读取配置相关" do
  describe "#simple_navbar error" do
    before(:all){
      @view = MOCK_VIEW
    }

    it {
      expect { 
        @view.simple_navbar(:admin)
      }.to raise_error(SimpleNavbar::UnconfigurationError)
    }

    it {
      require 'config/simple_navbar_config'
      expect {
        @view.simple_navbar(:a)
      }.to raise_error(SimpleNavbar::UndefinedRuleError)
    }
  end

  describe "SimpleNavbar::Rule" do
    before(:all) {
      require 'config/simple_navbar_config'
    }

    it 'simple' do
      rule = SimpleNavbar::Rule.get(:simple)
      rule.title.should == :simple

      navs = rule.navs
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
      
      navs = rule.navs
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

      rule_1.navs.length == 4
      rule_1.navs.length == rule_2.navs.length
    end

    it 'admin' do
      rule_admin = SimpleNavbar::Rule.get(:admin)
      nav = rule_admin.navs[0]

      nav.title.should == :index
      nav.controller_items.length == 1
      nav.controller_items[0].controller_name.should == :'admin/index'
    end

  end

  describe '#simple_navbar' do
    before(:all) {
      html_str = MOCK_VIEW.simple_navbar(:simple)
      puts html_str

      @xml = Nokogiri::XML(html_str)
    }

    it {
      @xml.at_css('.page-navbar > .navbar-inner > ul.nav > li.active > a').
        content.should == '首页'
    }

    it {
      @xml.css('.page-navbar > .navbar-inner > ul.nav > li > a')[1].
        content.should == '书籍'
    }

    it {
      @xml.css('.page-navbar > .navbar-inner > ul.nav > li > a')[2].
        content.should == '电影'
    }

    it {
      @xml.css('.page-navbar > .navbar-inner > ul.nav > li > a')[3].
        content.should == '音乐'
    }

  end
end
