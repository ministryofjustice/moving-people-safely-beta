class HealthcareForm
  class TransformAttributes
    def initialize(attributes)
      @attributes = attributes
    end

    attr_accessor :attributes

    def call
      prepare_medications_for_active_record!
      remove_unnecessary_medications_forms!

      attributes
    end

  private

    def prepare_medications_for_active_record!
      attributes[:medications_attributes] =
        filtered_medications_as_hashes
    end

    def filtered_medications_as_hashes
      attributes[:medications].reject(&:empty?).map(&:to_h)
    end

    def remove_unnecessary_medications_forms!
      attributes.delete(:medications)
    end
  end
end
