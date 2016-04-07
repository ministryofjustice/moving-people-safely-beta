RSpec.shared_examples 'a form that syncs to a model' do
  subject { described_class.new create(:escort) }

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
