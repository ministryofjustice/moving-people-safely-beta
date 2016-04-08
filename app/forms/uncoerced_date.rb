# Ensure nil values and Hashes behave in a similar
# fashion to Date objects so that invalid dates
# can be displayed back to the user.

class UncoercedDate
  include Virtus.value_object

  attribute :day, String
  attribute :month, String
  attribute :year, String
end
