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
      }.to raise_error(SimpleNavbar::Config::UnconfigurationError)
    }

    it {
      require 'config/simple_navbar_config'
      expect {
        @view.simple_navbar(:a)
      }.to raise_error(SimpleNavbar::Config::UndefinedRuleError)
    }
  end

  describe "解析配置文件" do
    before(:all) {
      require 'config/simple_navbar_config'
    }

    describe 'simple' do
      before(:all){
        @rule = SimpleNavbar::Config::Rule.get(:simple)
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
        @rule = SimpleNavbar::Config::Rule.get(:multi_level_example)
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
        @rule_1 = SimpleNavbar::Config::Rule.get(:rule_1)
        @rule_2 = SimpleNavbar::Config::Rule.get(:rule_2)
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
        @rule_admin = SimpleNavbar::Config::Rule.get(:admin)
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

end
