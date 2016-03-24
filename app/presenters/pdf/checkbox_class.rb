module Pdf
  module CheckboxClass
    extend ActiveSupport::Concern

    CHECKED_CLASS = 'checked'

    included do
      private

      def checked_class_for(value)
        if value
          CHECKED_CLASS
        end
      end
    end
  end
end
