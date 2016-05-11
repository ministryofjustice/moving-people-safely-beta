class PrisonerForm
  class TransformAttributes
    def initialize(attributes)
      @attributes = attributes
    end

    attr_accessor :attributes

    def call
      if attributes[:has_aliases]
        attributes[:aliases].reject!(&:blank?)
      else
        attributes[:aliases].clear
      end

      attributes
    end
  end
end
