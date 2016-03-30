RSpec.shared_context 'a form with maybe boolean attributes' do |attributes|
  # We should expect the subject to be a type of Escort
  attributes.each do |attribute|
    {
      'true'    => true,
      'false'   => false,
      'unknown' => nil
    }.each do |radio_button_value, coerced_value|
      describe "#{attribute}=" do
        context "coercing #{radio_button_value}" do
          before { subject.public_send("#{attribute}=", radio_button_value) }
          its(attribute) { is_expected.to be coerced_value }
        end
      end
    end
  end
end
