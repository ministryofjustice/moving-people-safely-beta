RSpec.shared_examples 'a form that coerces attributes' do |input_attributes, coerced_attribute = {}|
  subject { described_class.new create(:escort) }

  describe '#assign_attributes' do
    it 'updates the attributes on the form' do
      coerced_attributes = input_attributes.merge(coerced_attribute)
      subject.assign_attributes(input_attributes)

      expect(subject.attributes).to include(coerced_attributes)
    end
  end
end
