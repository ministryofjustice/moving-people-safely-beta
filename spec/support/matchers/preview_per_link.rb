RSpec::Matchers.define :have_preview_per_link do
  match do |page|
    link_text = I18n.t('quick_actions.preview')
    @actual = page.find('a', text: link_text)[:href]
    @expected = pdf_path(escort)
    @actual == @expected
  end

  failure_message do
    "Expected to find #{@expected} but found #{@actual}"
  end
end
