class Form
  module PrisonNumber
    extend ActiveSupport::Concern

    PRISON_NUMBER_REGEX = /\A[a-z]\d{4}[a-z]{2}\z/i

    class UpcasedString < Virtus::Attribute
      def coerce(value)
        value.to_s.upcase
      end
    end

    included do
      attribute :prison_number, UpcasedString
      validates :prison_number, format: { with: PRISON_NUMBER_REGEX }
    end
  end
end
