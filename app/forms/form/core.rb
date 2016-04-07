class Form
  module Core
    extend ActiveSupport::Concern

    included do
      include Virtus.model
      include ActiveModel::Conversion
      include ActiveModel::Validations

      def self.model_name
        ActiveModel::Name.new(self, nil, name.underscore.sub(/_form\Z/, ''))
      end

      def name
        self.class.model_name.to_s.underscore.downcase
      end
      alias_method :template, :name
    end
  end
end
