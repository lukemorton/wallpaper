require_relative './form'
require_relative './view_model'

module Wall
  class Controller
  	def initialize(di)
      @di = di
  	end

    def view()
      view_data = {
        :form => form,
        :latest_posts => posts.find_latest(mappers[:post]),
      }

      if request.cookies.has_key?("success")
        view_data[:success] = true
        response.delete_cookie(:success)
      end

      response.body = ViewModel.new(view_data).render
      return response
    end

    def action()
      begin
        interaction.post(mappers[:post], form.data)
        response.set_cookie(:success, true)
        response.redirect('/')
      rescue validation_exception => e
        form.errors = e.errors
        view
      rescue Exception => e
        p e
        response.body = 'unrecoverable'
      end
      
      return response
    end

  private

    def di()
      @di
    end

    def request()
      di[:request]
    end

    def response()
      di[:response]
    end

    def mappers()
      di[:mappers]
    end

    def posts()
      di[:posts]
    end

    def interaction()
      di[:interaction]
    end

    def validation_exception()
      di[:validation_exception]
    end

    def form()
      @form ||= Form.new(request.POST)
    end
  end
end