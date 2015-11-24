require 'spec_helper'

describe "simple_navtabs" do
  before(:all) {
    require 'config/simple_navbar_config'
    @view = MOCK_VIEW
    def @view.params
      {
        "controller" => "index",
        "action"     => "index"
      }
    end

    html_str = @view.simple_navtabs(:simple_navtabs_1)
    @xml = Nokogiri::XML(html_str)
  }

  it {
    @xml.css('ul.nav.nav-tabs > li > a')[0].
      content.should == '书籍'
  }

  it {
    @xml.css('ul.nav.nav-tabs > li > a')[1].
      content.should == '电影'
  }

  it {
    @xml.css('ul.nav.nav-tabs > li > a')[2].
      content.should == '音乐'
  }

  describe "被点亮" do
    before(:all){
      @view = MOCK_VIEW
      def @view.params
        {
          "controller" => "musics",
          "action"     => "index"
        }
      end
      html_str = @view.simple_navtabs(:simple_navtabs_1)
      @xml = Nokogiri::XML(html_str)
    }

    it{
      @xml.css('ul.nav.nav-tabs > li.active > a')[0].
        content.should == '音乐'
    }
  end

end
