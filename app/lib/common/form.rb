module Common
  class Form
    attr_writer :data, :errors

    def initialize(data = nil)
      self << data unless data.nil?
      @errors = {}
    end

    # Return a hash of symbols
    def fields()
      []
    end

    def data()
      @data ||= {}
    end

    def errors()
      @errors ||= {}
    end

    def <<(new_data)
      new_data = new_data.each_with_object({}) do |(k, v), hash|
        hash[k.to_sym] = v
      end

      fields.each do |field|
        data[field] = new_data[field] if new_data.has_key?(field)
      end
    end

    def [](key)
      key_sym = key.to_sym
      field = {}

      if data.has_key?(key_sym)
        field[:value] = data[key_sym]
      end

      if errors.has_key?(key_sym)
        field[:error] = errors[key_sym]
      end

      return field
    end

    def to_h()
      hash = {}

      fields.each do |field|
        hash[field] = self[field]
      end

      return hash
    end

    def valid?()
      errors.empty?
    end
  end
end