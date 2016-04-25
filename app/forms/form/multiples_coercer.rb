class Form
  module MultiplesCoercer
  module_function

    def call(input)
      if input.is_a?(Hash)
        input.values
      else
        input.map(&:attributes)
      end
    end
  end
end
