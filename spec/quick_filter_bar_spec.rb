require 'spec_helper'


describe "quick_filter_bar" do
    before(:all){
      @view = MOCK_VIEW

      def @view.params
        {
          :kind => "pop"
        }
      end

      def @view.request
        request = ActionDispatch::Request.new({})
        def request.fullpath
          "/list?kind=pop"
        end
        request
      end

      html = @view.quick_filter_bar do |builder|
        builder.group :kind, :text => "音乐类型" do |group|
          group.add "rock",   :text => "摇滚"
          group.add "pop", :text => "流行"
        end

        builder.group :lang, :text => "语种" do |group|
          group.add "china",   :text => "华语"
          group.add "english", :text => "英语"
        end
      end

      @xml = Nokogiri::XML(html)
    }

    it {
      @xml.at_css(".quick_filter_bar .quick_filter_bar_group .title").content.should == "音乐类型"
    }

    it {
      @xml.at_css(".quick_filter_bar .quick_filter_bar_group:first-child ul li.active a").content.should == "流行"
    }

    it {
      @xml.at_css(".quick_filter_bar .quick_filter_bar_group:first-child ul li.active a")["href"].should == "/list?kind=pop"
    }

    it {
      a = @xml.at_css(".quick_filter_bar .quick_filter_bar_group:last-child ul li:first-child a")
      a["href"].should == "/list?kind=pop"
      a.content.should == "全部"
    }


    it {
      li = @xml.at_css(".quick_filter_bar .quick_filter_bar_group:last-child ul li:first-child")
      li["class"].should == "active"
    }

    it {
      a = @xml.at_css(".quick_filter_bar .quick_filter_bar_group:last-child ul li:last-child a")
      a["href"].should == "/list?kind=pop&lang=english"
      a.content.should == "英语"
    }

    describe "fix bug /list?a=1&kind=" do
      before(:all){
        @view = MOCK_VIEW

        def @view.params
          {
            :kind => "",
            :a    => "1"
          }
        end

        def @view.request
          request = ActionDispatch::Request.new({})
          def request.fullpath
            "/list?a=1&kind="
          end
          request
        end

        html = @view.quick_filter_bar do |builder|
          builder.group :kind, :text => "音乐类型" do |group|
            group.add "rock",   :text => "摇滚"
            group.add "pop", :text => "流行"
          end

          builder.group :lang, :text => "语种" do |group|
            group.add "china",   :text => "华语"
            group.add "english", :text => "英语"
          end
        end

        @xml = Nokogiri::XML(html)
      }

      it {
        a = @xml.at_css(".quick_filter_bar .quick_filter_bar_group:last-child ul li:first-child a")
        a["href"].should == "/list?a=1&kind="
        a.content.should == "全部"
      }
    end
end
