module Wallpaper
  module Wall
    module Posts
      def self.find_latest(mapper)
        mapper.find_latest
      end
    end
  end
end