module SimpleNavbar
  module Render
    module QuickFilterBar
      class UrlQueryString
        def self.encode(hash)
          URI.encode "?#{hash.map { |key,value| "#{key}=#{value}" }*"&"}"
        end

        def self.decode(query)
          query.gsub("?","").split("&").map{|str|str.split("=")}.each{|arr|
            value = arr[1] || ""
            arr[1] = URI.decode value
          }.to_h
        end
      end
    end
  end
end
