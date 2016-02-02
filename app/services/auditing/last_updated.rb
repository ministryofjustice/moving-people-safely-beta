module Auditing
  module LastUpdated
    SQL = 'object_changes ?| array[%{attribute_names}]'

  module_function

    def for(fields, record)
      PaperTrail::Version.
        where(item_type: record.class.name).
        where(item_id: record.id).
        where(
          SQL % { attribute_names: fields.map(&method(:quoted)).join(',') }
        ).last || record.versions.first
    end

    def quoted(field)
      "\'#{field}\'"
    end

    private_class_method :quoted
  end
end
