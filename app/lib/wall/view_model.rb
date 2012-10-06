require 'mustache'

module Wall
  class ViewModel < Mustache
    def self.template_file()
      File.dirname(__FILE__)+'/../../templates/wall.mustache'
    end

    def initialize(data)
      @data = data
    end

    def post()
      {
        :success => data.has_key?(:success) ? data[:success] : false,
        :content => {
          :value => form.data[:content],
          :error => error(:content),
        }
      }
    end

    def latest_posts()
      data[:latest_posts]
    end

    def has_latest_posts()
      latest_posts.empty? == false
    end

  private

    def data()
      @data
    end

    def form()
      data[:form]
    end

    def error(key)
      if form.errors.has_key?(key)
        return form.errors[key].join('')
      end

      return []
    end
  end
end