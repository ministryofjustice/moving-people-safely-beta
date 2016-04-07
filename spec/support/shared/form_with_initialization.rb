RSpec.shared_examples 'a form that loads model attributes on initialize' do
  subject { described_class.new create(:escort) }

  describe '#initialize' do
    it 'loads a models attributes' do
      form_attrs = subject.attributes.with_indifferent_access
      model_attrs = subject.target.attributes.with_indifferent_access
      expect(model_attrs).to include form_attrs
    end
  end
end
