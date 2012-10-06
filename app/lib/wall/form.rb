module Wall
  class Form
    attr_accessor :data, :errors

    def initialize(data)
      @data = {:content => data["content"]}
      @errors = {}
    end

    def valid?()
      errors.empty?
    end
  end
end