module Common
  module DI
    module InjectedController
      def di()
        @di ||= {}
      end

      def request()
        di[:request]
      end

      def response()
        di[:response]
      end
    end
  end
end