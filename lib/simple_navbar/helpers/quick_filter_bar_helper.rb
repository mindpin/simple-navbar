module SimpleNavbar
  module Helpers
    module QuickFilterBarHelper
      # = quick_filter_bar do |builder|
      #   - builder.group :state, :text => "状态" do |group|
      #     - group.add "answed",   :text => "已回答"
      #     - group.add "unanswed", :text => "未回答"
      def quick_filter_bar(&block)
        builder = ::SimpleNavbar::Render::QuickFilterBar::Builder.new(self)
        block.call(builder)
        builder.render
      end
    end
  end
end
