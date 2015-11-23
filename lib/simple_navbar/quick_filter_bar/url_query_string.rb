module SimpleNavbar
  module QuickFilterBar
    class UrlQueryString
      def self.encode(hash)
        URI.encode "?#{hash.map { |key,value| "#{key}=#{value}" }*"&"}"
      end

      def self.decode(query)
        query.gsub("?","").split("&").map{|str|str.split("=")}.each{|arr|arr[1] = URI.decode arr[1]}.to_h
      end
    end
  end
end
