require 'spec_helper'

describe "simple_breadcrumbs" do
  before(:all){
    require 'config/simple_navbar_config'
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
