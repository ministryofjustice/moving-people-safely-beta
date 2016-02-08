module DateParsing
  extend ActiveSupport::Concern

  included do
    def self.date(attribute_name)
      define_method(attribute_name) do
        instance_variable_get("@#{attribute_name}")
      end

      define_method("#{attribute_name}=") do |date|
        instance_variable_set("@#{attribute_name}",
          DateHashParser.new(date).perform)
      end
    end
  end
end
