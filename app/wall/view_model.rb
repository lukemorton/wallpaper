require 'mustache'

module Wall
  class ViewModel < Mustache
    def self.template_file()
      File.dirname(__FILE__)+'/wall.mustache'
    end

    def initialize(data)
      @data = data
    end

    def post()
      post = data[:form].to_h
      post[:success] = data.has_key?(:success) ? data[:success] : false
      return post
    end

    def latest_posts()
      data[:latest_posts]
    end

    def has_latest_posts()
      latest_posts.empty? == false
    end

  private

    attr_reader :data
  end
end