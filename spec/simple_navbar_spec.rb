require 'spec_helper'

describe "simple_navbar" do
  describe "默认" do
    before(:all) {
      require 'config/simple_navbar_config'
      @view = MOCK_VIEW
      def @view.params
        {
          "controller" => "index",
          "action"     => "index"
        }
      end
      html_str = @view.simple_navbar(:multi_level_example)
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

    describe "被点亮 nav" do
      before(:all){
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

  end

  describe "bootstrap mode" do
    before(:all) {
      require 'config/simple_navbar_config'
      @view = MOCK_VIEW
      def @view.params
        {
          "controller" => "index",
          "action"     => "index"
        }
      end
      html_str = @view.simple_navbar(:multi_level_example, :mode => :bootstrap)
      @xml = Nokogiri::XML(html_str)
    }

    it {
      @xml.at_css('.collapse.navbar-collapse > ul.nav.navbar-nav > li.active > a').
        content.should == '首页'
    }

    it {
      @xml.css('.collapse.navbar-collapse > ul.nav.navbar-nav > li > a')[1].
        content.should == '电影'
    }

    it {
      @xml.css('.collapse.navbar-collapse > ul.nav.navbar-nav > li > a')[2].
        content.should == '音乐'
    }

    it {
      @xml.css('.collapse.navbar-collapse > ul.nav.navbar-nav > li > ul.nav > li > a')[0].
        content.should == '流行音乐'
    }

    it {
      @xml.css('.collapse.navbar-collapse > ul.nav.navbar-nav > li > ul.nav.navbar-nav > li > ul.nav.navbar-nav > li > a')[0].
        content.should == '摇滚音乐'
    }

    it {
      @xml.css('.collapse.navbar-collapse > ul.nav.navbar-nav > li > ul.nav.navbar-nav > li > ul.nav.navbar-nav > li > ul.nav.navbar-nav > li > a')[0].
        content.should == '朋克'
    }

    describe "被点亮 nav" do
      before(:all){
        @view = MOCK_VIEW
        def @view.params
          {
            "controller" => "punk_musics",
            "action"     => "index"
          }
        end
        html_str = @view.simple_navbar(:multi_level_example, :mode => :bootstrap)
        @xml = Nokogiri::XML(html_str)
      }

      it{
        @xml.css('.collapse.navbar-collapse > ul.nav.navbar-nav li.musics.active .pop_musics.active .rock_musics.active .punk_musics.active a')[0].
          content.should == '朋克'
      }
    end

    describe "自定义 class" do
      before(:all) {
        require 'config/simple_navbar_config'
        @view = MOCK_VIEW
        def @view.params
          {
            "controller" => "index",
            "action"     => "index"
          }
        end
        html_str = @view.simple_navbar(:multi_level_example, :mode => :bootstrap, :class => "a b", :ul_class => "c d")
        @xml = Nokogiri::XML(html_str)
      }

      it {
        @xml.at_css('.collapse.navbar-collapse.a.b > ul.nav.navbar-nav.c.d > li.active > a').
          content.should == '首页'
      }

      it {
        @xml.css('.collapse.navbar-collapse.a.b > ul.nav.navbar-nav.c.d > li > a')[1].
          content.should == '电影'
      }

      it {
        @xml.css('.collapse.navbar-collapse.a.b > ul.nav.navbar-nav.c.d > li > a')[2].
          content.should == '音乐'
      }

      it {
        @xml.css('.collapse.navbar-collapse.a.b > ul.nav.navbar-nav.c.d > li > ul.nav.c.d > li > a')[0].
          content.should == '流行音乐'
      }

      it {
        @xml.css('.collapse.navbar-collapse.a.b > ul.nav.navbar-nav.c.d > li > ul.nav.navbar-nav.c.d > li > ul.nav.navbar-nav.c.d > li > a')[0].
          content.should == '摇滚音乐'
      }

      it {
        @xml.css('.collapse.navbar-collapse.a.b > ul.nav.navbar-nav.c.d > li > ul.nav.navbar-nav.c.d > li > ul.nav.navbar-nav.c.d > li > ul.nav.navbar-nav.c.d > li > a')[0].
          content.should == '朋克'
      }
    end
  end
end
