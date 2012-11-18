# `Common::Form` provides some sugar to dealing with form data
# values and errors.
# 
# For example you can create a child and define which fields
# are expected in the form like so:
# 
#     class LoginForm < Common::Form
#       def fields()
#         [:email, :password]
#       end
#     end
# 
# Then with this class you can pass in data and be assured
# only the expected data will be stored:
# 
#     post_data = {
#       :email    => 'hey@cool.com',
#       :password => 'pass',
#       :unwanted => 'hmm',
#     }
#     form = LoginForm.new(post_data)
#     form.data # => {:email => 'hey@cool.com', :password => 'pass'}
# 
# You don't have to pass in data straight away either:
# 
#     post_data = {
#       :email    => 'hey@cool.com',
#       :password => 'pass',
#       :unwanted => 'hmm',
#     }
#     form = LoginForm.new
#     form << post_data if request.post?
#     form.data # => {:email => 'hey@cool.com', :password => 'pass'}
# 
# Errors can be set:
# 
#     form = LoginForm.new({:email => '...', :password => '...'})
#     form.errors = {:email => ['Invalid e-mail']}
# 
# Validity checked:
# 
#     form = LoginForm.new({:email => '...', :password => '...'})
#     form.errors = {:email => ['Invalid e-mail']}
#     form.valid? # => false
# 
# And you can access everything as if the `Form` was a `Hash`:
# 
#     form = LoginForm.new({:email => '...', :password => '...'})
#     form.errors = {:email => ['Invalid e-mail']}
#     form[:email][:value] # => '...'
#     form[:email][:errors] # => ['Invalid e-mail']
#     form.errors # => {:email => ['Invalid e-mail']}
# 
# Oh or export everything as a `Hash`:
# 
#     form = LoginForm.new({:email => '...'})
#     form.errors = {:email => ['Invalid e-mail']}
#     form.to_h # => {:email => {:value => '...', :errors => ['Invalid e-mail']}}
# 
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
        field[:errors] = errors[key_sym]
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