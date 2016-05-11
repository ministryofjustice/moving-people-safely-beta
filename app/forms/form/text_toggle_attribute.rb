class Form
  module TextToggleAttribute
    extend ActiveSupport::Concern

    included do
      def self.text_toggle_attribute(attribute_name)
        attribute attribute_name,              MaybeBoolean
        attribute "#{attribute_name}_details", String

        allow_details_to_be_cleared_for attribute_name

        validates "#{attribute_name}_details",
          presence: true, if: "#{attribute_name}.present?"
      end

      def self.allow_details_to_be_cleared_for(attribute_name)
        define_method("#{attribute_name}_details=") do |text|
          if public_send(attribute_name)
            super(text)
          else
            super(nil)
          end
        end
      end
    end
  end
end
