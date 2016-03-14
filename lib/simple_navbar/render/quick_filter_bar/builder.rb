module SimpleNavbar
  module Render
    module QuickFilterBar
      class Builder
        attr_reader :groups

        def initialize(view)
          @view = view
          @groups = []
        end

        def group(param_name, options, &block)
          text = options[:text]
          group = ::SimpleNavbar::Render::QuickFilterBar::Group.new(@view, self, param_name, text: text)
          block.call(group)
          @groups << group
        end

        def render
          @view.capture_haml do
            @view.haml_tag :div, :class => "quick_filter_bar" do
              @groups.each do |group|
                group.render
              end
            end
          end
        end
      end
    end

  end
end
