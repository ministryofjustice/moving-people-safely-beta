# Ensure nil values and Hashes behave in a similar
# fashion to Date objects so that invalid dates
# can be displayed back to the user.

class UncoercedDate < OpenStruct
  %i[ day month year ].each do |method_name|
    define_method(method_name) { super() }
  end
end
