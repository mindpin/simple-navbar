# -*- encoding : utf-8 -*-
require 'spec_helper'


describe "读取配置相关" do
  describe "#simple_navbar error" do
    before(:each){
      @view = MOCK_VIEW
      def @view.params
        {
          "controller" => "index",
          "action"     => "index"
        }
      end
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

    describe 'simple' do
      before(:all){
        @rule = SimpleNavbar::Rule.get(:simple)
      }

      it{
        @rule.title.should == :simple
      }

      it{
        @rule.navs.length.should == 4
      }

      it{
        @rule.navs[0].title.should == :index
      }

      it{
        @rule.navs[0].options.url.should == '/'
      }

      it{
        @rule.navs[0].options.name.should == '首页'
      }

      it{
        controller_items = @rule.navs[0].controller_items
        controller_items.length.should == 1
      }

      it{
        controller_item = @rule.navs[0].controller_items[0]
        controller_item.controller_name.should == :index
      }

      it{
        @rule.navs[1].title.should == :books
      }

      it{
        @rule.navs[2].title.should == :movies
      }

      it{
        @rule.navs[3].title.should == :musics
      }

    end

    describe 'multi_level_example' do
      before(:all){
        @rule = SimpleNavbar::Rule.get(:multi_level_example)
        @rock_nav = @rule.navs[2].subnavs[0].subnavs[0]
        @pop_controller_items = @rule.navs[2].subnavs[0].controller_items
      }

      it{
        @rule.title.should == :multi_level_example
      }

      it{
        @rule.navs.length.should == 3
      }

      it{
        @rule.navs[2].controller_items.length.should == 1
      }

      it{
        @rule.navs[2].controller_items[0].controller_name.should == :musics
      }

      it{
        @rule.navs[2].subnavs.length.should == 1
      }

      it{
        @rule.navs[2].subnavs[0].controller_items.length == 3
      }

      it{
        @pop_controller_items[0].controller_name.should == :pop_musics
      }

      it{
        @rule.navs[2].subnavs[0].subnavs.length.should == 1
      }

      it{
        @rock_nav.controller_items.length == 2
      }

      it{
        @rock_nav.controller_items[0].controller_name.should == :rock_musics
      }

      it{
        @rock_nav.subnavs.length.should == 1
      }

      it{
        @rock_nav.subnavs[0].controller_items.length == 1
      }

      it{
        @rock_nav.subnavs[0].controller_items[0].controller_name.should == :punk_musics
      }

    end

    describe 'mutil_rule' do
      before(:all){
        @rule_1 = SimpleNavbar::Rule.get(:rule_1)
        @rule_2 = SimpleNavbar::Rule.get(:rule_2)
      }

      it{
        @rule_1.title.should == :rule_1
      }

      it{
        @rule_2.title.should == :rule_2
      }

      it{
        @rule_1.navs.length == 4
      }

      it{
        @rule_1.navs.length == @rule_2.navs.length
      }
    end

    describe 'admin' do
      before(:all){
        @rule_admin = SimpleNavbar::Rule.get(:admin)
        @nav = @rule_admin.navs[0]
      }

      it{
        @nav.title.should == :index
      }

      it{
        @nav.controller_items.length == 1
      }

      it{
        @nav.controller_items[0].controller_name.should == :'admin/index'
      }
    end

  end

  describe '#simple_navbar' do
    before(:all) {
      html_str = MOCK_VIEW.simple_navbar(:multi_level_example)
      @xml = Nokogiri::XML(html_str)
    }

    it {
      @xml.at_css('.page-navbar > .navbar-inner > ul.nav > li.active > a').
        content.should == '首页'
    }

    it {
      @xml.css('.page-navbar > .navbar-inner > ul.nav > li > a')[1].
        content.should == '电影'
    }

    it {
      @xml.css('.page-navbar > .navbar-inner > ul.nav > li > a')[2].
        content.should == '音乐'
    }

    it {
      @xml.css('.page-navbar > .navbar-inner > ul.nav > li > ul.nav > li > a')[0].
        content.should == '流行音乐'
    }

    it {
      @xml.css('.page-navbar > .navbar-inner > ul.nav > li > ul.nav > li > ul.nav > li > a')[0].
        content.should == '摇滚音乐'
    }

    it {
      @xml.css('.page-navbar > .navbar-inner > ul.nav > li > ul.nav > li > ul.nav > li > ul.nav > li > a')[0].
        content.should == '朋克'
    }

  end


  describe "被点亮 nav" do
    before(:each){
      @view = MOCK_VIEW
      def @view.params
        {
          "controller" => "punk_musics",
          "action"     => "index"
        }
      end
      html_str = @view.simple_navbar(:multi_level_example)
      @xml = Nokogiri::XML(html_str)
    }

    it{
      @xml.css('.page-navbar > .navbar-inner li.musics.active .pop_musics.active .rock_musics.active .punk_musics.active a')[0].
        content.should == '朋克'
    }
  end


  describe "Breadcrumbs" do
    before(:each){
      @view = MOCK_VIEW
      def @view.params
        {
          "controller" => "punk_musics",
          "action"     => "index"
        }
      end

    }

    it{
      xml = @view.simple_breadcrumbs(:multi_level_example)
      doc = Nokogiri::XML(xml)
      res = doc.css("ol.breadcrumb li").map{ |n| n.inner_html.strip}
      expect(res).to eq(["<a href=\"/musics\">&#x97F3;&#x4E50;</a>", "<a href=\"/musics/pop\">&#x6D41;&#x884C;&#x97F3;&#x4E50;</a>", "<a href=\"/musics/pop/rock\">&#x6447;&#x6EDA;&#x97F3;&#x4E50;</a>", "&#x670B;&#x514B;"])
    }

    it{
      xml = @view.simple_breadcrumbs(:multi_level_example) do |b|
        b.add "a","/a"
        b.add "ab","/a/b"
      end
      doc = Nokogiri::XML(xml)
      res = doc.css("ol.breadcrumb li").map{ |n| n.inner_html.strip}
      expect(res).to eq(["<a href=\"/musics\">&#x97F3;&#x4E50;</a>", "<a href=\"/musics/pop\">&#x6D41;&#x884C;&#x97F3;&#x4E50;</a>", "<a href=\"/musics/pop/rock\">&#x6447;&#x6EDA;&#x97F3;&#x4E50;</a>", "<a href=\"/musics/pop/rock/punk\">&#x670B;&#x514B;</a>", "<a href=\"/a\">a</a>", "ab"])
    }
  end

end
