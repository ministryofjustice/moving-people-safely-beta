class OffencesForm
  class TransformAttributes
    def initialize(attributes)
      @attributes = attributes
    end

    attr_accessor :attributes

    def call
      prepare_offence_details_for_active_record!
      remove_unnecessary_offence_details_forms!

      attributes
    end

  private

    def prepare_offence_details_for_active_record!
      attributes[:offence_details_attributes] =
        filtered_offence_details_as_hashes
    end

    def filtered_offence_details_as_hashes
      attributes[:offence_details].reject(&:empty?).map(&:to_h)
    end

    def remove_unnecessary_offence_details_forms!
      attributes.delete(:offence_details)
    end
  end
end
