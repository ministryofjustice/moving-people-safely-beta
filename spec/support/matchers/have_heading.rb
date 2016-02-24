RSpec::Matchers.define :have_heading do |expected_heading|
  match do |page|
    page.has_css?('header h1', text: expected_heading)
  end
  failure_message do
    "expected page to have heading: #{expected_heading}"
  end
end
