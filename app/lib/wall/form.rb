require_relative '../common/form'

module Wall
  class Form < Common::Form
    def fields()
      [:content]
    end
  end
end