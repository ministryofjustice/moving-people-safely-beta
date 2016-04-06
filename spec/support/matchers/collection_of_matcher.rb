RSpec::Matchers.define :be_a_collection_of do |expected_type|
  match do |collection|
    collection.all? { |e| e.is_a?(expected_type) } && collection.size == @size
  end

  chain :of_size do |size|
    @size = size
  end

  failure_message do
    "expected to be a collection of #{@size} #{expected_type}(s)"
  end
end
