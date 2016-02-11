class Form
  module TextToggleAttribute
    extend ActiveSupport::Concern

    class MaybeBoolean < Virtus::Attribute::Boolean
      def coerce(value)
        super if super.in? [true, false]
      end
    end

    included do
      def self.text_toggle_attribute(attribute_name)
        attribute attribute_name,              MaybeBoolean
        attribute "#{attribute_name}_details", String
      end
    end
  end
end
