class View
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