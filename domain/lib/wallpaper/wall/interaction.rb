require File.dirname(__FILE__) + '/post/input_validation'
require File.dirname(__FILE__) + '/../validation_exception'

module Wallpaper
  module Wall
    module Interaction
      def self.post(mapper, data)
        input = Post::InputValidation.new(data)

        unless input.valid?
          raise Wallpaper::ValidationException.new(input.errors)
        end

        mapper.create(input.data)
      end
    end
  end
end