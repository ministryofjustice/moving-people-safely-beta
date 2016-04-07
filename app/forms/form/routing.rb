class Form
  module Routing
    FORM_NAMES = %i[ prisoner move risks healthcare offences ]

    FormData = Struct.new(:name) do
      def path
        name.to_s.dasherize
      end
    end

  module_function

    def resource_list
      form_names.map { |name| FormData.new(name) }
    end

    def form_names
      FORM_NAMES
    end
  end
end
