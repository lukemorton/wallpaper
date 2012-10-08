require_relative '../common/controller'
require_relative './form'
require_relative './view_model'

module Wall
  class Controller < Common::Controller

    def view()
      view_data[:form] = form
      view_data[:latest_posts] = di[:posts].find_latest(di[:mappers][:post])

      if request.cookies.has_key?("success")
        view_data[:success] = true
        response.delete_cookie(:success)
      end

      response.body = ViewModel.new(view_data).render
      return response
    end

    def action()
      begin
        di[:interaction].post(di[:mappers][:post], form.data)
      rescue di[:validation_exception] => e
        form.errors = e.errors
        view
      else
        response.set_cookie(:success, true)
        response.redirect('/')
      end
      
      return response
    end

  private

    def form()
      @form ||= Form.new(request.POST)
    end

    def view_data()
      @view_data ||= {}
    end
  end
end