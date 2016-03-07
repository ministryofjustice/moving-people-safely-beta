module Summary
  class MovePresenter
    def initialize(model)
      @model = model
    end

    delegate :origin, :destination, :date_of_travel, :reason, to: :@model
    private :date_of_travel

    def edit_section_path
      Rails.application.routes.url_helpers.move_information_path(@model.escort)
    end

    def formatted_date_of_travel
      if date_of_travel.present?
        date_of_travel.strftime('%d/%m/%Y')
      end
    end
  end
end
