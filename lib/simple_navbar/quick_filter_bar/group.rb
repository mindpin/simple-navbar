module SimpleNavbar
  module QuickFilterBar
    class Group
      attr_reader :builder, :param_name, :items

      def initialize(view, builder, param_name, text:)
        @view    = view
        @builder = builder

        @param_name = param_name.to_s
        @text = text

        @items = []

        @items << SimpleNavbar::QuickFilterBar::GroupItem.new(@view, self, nil, text: "全部")
      end

      def add(param_value, text:)
        @items << SimpleNavbar::QuickFilterBar::GroupItem.new(@view, self, param_value, text: text)
      end

      def render
        @view.haml_tag :div, :class => "quick_filter_bar_group" do
          @view.haml_tag :div, @text, :class => "title"
          @view.haml_tag :ul do
            @items.each do |item|
              item.render
            end
          end
        end
      end

    end

  end
end
