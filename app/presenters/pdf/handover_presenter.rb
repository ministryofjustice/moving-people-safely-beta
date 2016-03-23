module Pdf
  class HandoverPresenter
    def initialize(model)
      @model = model
    end

    delegate :must_return_details, :must_not_return_details, to: :@model

    def must_return_class
      if @model.must_return
        Pdf::HtmlClasses.checked
      end
    end

    def must_not_return_class
      if @model.must_not_return
        Pdf::HtmlClasses.checked
      end
    end
  end
end
