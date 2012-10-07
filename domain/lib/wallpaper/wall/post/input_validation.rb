module Wallpaper
  module Wall
    module Post
      class InputValidation
        attr_reader :data, :errors

        def initialize(data)
          @data = {:content => data[:content]}
          @errors = {}
          @done = false
        end

        def validate!()
          if not data.has_key?(:content) or data[:content].empty?
            errors[:content] = ['Content must not be empty']
          end
        end

        def valid?()
          validate! unless done?
          return errors.empty?
        end

      private

        def done?()
          @done
        end
      end
    end
  end
end