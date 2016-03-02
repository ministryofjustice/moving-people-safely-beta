class Form
  module Core
    extend ActiveSupport::Concern

    included do
      include Virtus.model
      include ActiveModel::Conversion
      include ActiveModel::Validations

      def name
        self.class.name.underscore.downcase
      end
      alias_method :template, :name
    end
  end
end
