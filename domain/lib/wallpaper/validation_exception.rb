module Wallpaper
  class ValidationException < Exception
    attr_reader :errors

    def initialize(errors)
      @errors = errors
    end
  end
end