module Pdf
  class MovePresenter
    def initialize(model)
      @model = model
    end

    delegate :origin, :destination, :date_of_travel, :reason, to: :@model
    private :date_of_travel

    delegate :day, :month, :year,
      to: :date_of_travel, prefix: true, allow_nil: true
  end
end
