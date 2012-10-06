require File.dirname(__FILE__) + '/post/input_validation'
require File.dirname(__FILE__) + '/../validation_exception'

module Wallpaper
  module Wall
    module Interaction
      def self.post(mapper, data)
        validation = Post::InputValidation.new(data)

        unless validation.valid?
          raise Wallpaper::ValidationException.new(validation.errors)
        end

        mapper.create(validation.data)
      end
    end
  end
end