require_relative './di/injected_controller'

module Common
  class Controller
    include DI::InjectedController

    def initialize(di)
      @di = di
    end
  end
end