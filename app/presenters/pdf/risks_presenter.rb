module Pdf
  class RisksPresenter
    def initialize(model)
      @model = model
    end

    delegate :to_self_details, :violence_details, :from_others_details,
      :escape_details, :intolerant_behaviour_details,
      :prohibited_items_details, :non_association_details,
      to: :@model
  end
end
