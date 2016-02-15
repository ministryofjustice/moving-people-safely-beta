RSpec.shared_examples 'a form that syncs to a model' do |input_attributes, coerced_attribute = {}|
  subject { described_class.new create(:escort) }
  coerced_attributes = input_attributes.merge(coerced_attribute)

  describe '#initialize' do
    it 'loads a models attributes' do
      form_attrs = subject.attributes.with_indifferent_access
      model_attrs = subject.target.attributes.with_indifferent_access
      expect(model_attrs).to include form_attrs
    end
  end

  describe '#assign_attributes' do
    it 'updates the attributes on the form' do
      subject.assign_attributes(input_attributes)

      expect(subject.attributes).to include(coerced_attributes)
    end
  end

  describe '#save' do
    context 'with valid attributes' do
      before { allow(subject).to receive(:valid?).and_return true }

      it 'passes the forms data to the underlying model' do
        expect(subject.target).
          to receive(:update_attributes).with subject.attributes

        subject.save
      end

      it 'returns true' do
        expect(subject.save).to be true
      end
    end

    context 'with invalid attributes' do
      before { allow(subject).to receive(:valid?).and_return false }

      it 'does not pass the forms data to the underlying model' do
        expect(subject.target).not_to receive(:update_attributes)
        subject.save
      end

      it 'returns false' do
        expect(subject.save).to be false
      end
    end
  end
end
