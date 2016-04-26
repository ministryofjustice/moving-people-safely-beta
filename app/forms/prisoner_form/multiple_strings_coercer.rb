class PrisonerForm
  module MultipleStringsCoercer
  module_function

    def call(collection)
      if collection.is_a? Hash
        collection.values
      else
        collection
      end
    end
  end
end
