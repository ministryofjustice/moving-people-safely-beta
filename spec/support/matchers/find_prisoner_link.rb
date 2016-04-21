RSpec::Matchers.define :have_find_prisoner_link do
  match do |page|
    link_text = I18n.t('quick_actions.find_prisoner')
    @actual = page.find('a', text: link_text)[:href]
    @expected = root_path(escort)
    @actual == @expected
  end

  failure_message do
    "Expected to find #{@expected} but found #{@actual}"
  end
end
