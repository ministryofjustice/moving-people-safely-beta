class Form
  module DateHandling
    extend ActiveSupport::Concern

    included do
      class << self
        def date(attribute_name)
          attribute attribute_name, Date
          validates attribute_name, date: true
          build_date_attribute_setter_for attribute_name
          build_date_presenter_for attribute_name
        end

        def build_date_attribute_setter_for(attribute_name)
          define_method("#{attribute_name}=") do |date|
            begin
              super coerce_date(date)
            rescue ArgumentError # E.g. Out of range dates 22-54-2010
              instance_variable_set :"@#{attribute_name}", date
            end
          end
        end

        def build_date_presenter_for(attribute_name)
          # The purpose of this method is to provide an object
          # that behaves like a date for use in the view layer.
          # In this case an object is required to respond to
          # day, month or year messages. When a date cannot be
          # coerced or is nil an UncoercedDate instance is returned.
          define_method("#{attribute_name}_presenter") do
            value = public_send(attribute_name)
            value.is_a?(Date) ? value : UncoercedDate.new(value)
          end
        end
      end

    private

      def coerce_date(date)
        if date.respond_to?(:symbolize_keys)
          date.symbolize_keys if date.values.any?(&:present?)
        else
          date
        end
      end
    end
  end
end
