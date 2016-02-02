module PresenterAttributes
  module HandleEmpty
    class Text < Virtus::Attribute
      def coerce(value)
        value.blank? ? HandleEmpty.empty_text : value
      end
    end

    class CapitalizedFirstChar < Text
      def coerce(value)
        value.present? ? value.chr.capitalize : super
      end
    end

    class FormattedDate < Text
      def coerce(value)
        value.present? ? value.strftime('%d/%m/%Y') : super
      end
    end

  module_function

    def empty_text
      I18n.t('escorts.summary.empty_text')
    end
  end
end
