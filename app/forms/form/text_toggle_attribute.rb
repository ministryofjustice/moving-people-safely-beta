class Form
  module TextToggleAttribute
    extend ActiveSupport::Concern

    included do
      def self.text_toggle_attribute(attribute_name)
        attribute attribute_name,              Boolean
        attribute "#{attribute_name}_details", String
      end
    end
  end
end
