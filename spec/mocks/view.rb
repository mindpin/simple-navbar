class View < ActionView::Base
  include SimpleNavbar::Helpers

  def params
    {
      "controller" => "index",
      "action"     => "index"
    }
  end

  def raw(str)
    str
  end
end