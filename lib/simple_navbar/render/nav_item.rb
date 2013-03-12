# -*- encoding : utf-8 -*-
module SimpleNavbar
  module Render
    class NavItem < SimplePageCompoents::NavItem
      attr_accessor :controller_items

      def is_active?
        controller = @view.params["controller"].to_sym
        action = @view.params["action"].to_sym

        self.controller_items.each do |item|
          return true if item.is_current?(controller, action)
        end

        @items.each do |nav|
          return true if nav.is_active?
        end
        
        return false
      end

    end
  end
end
