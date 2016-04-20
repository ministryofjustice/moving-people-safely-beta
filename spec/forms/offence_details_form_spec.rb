RSpec.describe OffenceDetailsForm, type: :form do
  describe '#persisted?' do
    context 'when id is present' do
      subject { described_class.new(id: '1') }
      it { is_expected.to be_persisted }
    end

    context 'when id is not present' do
      subject { described_class.new(id: nil) }
      it { is_expected.not_to be_persisted }
    end
  end

  describe '#empty?' do
    context 'when the fields are empty' do
      subject { described_class.new(offence_type: '', offence_status: '') }
      it { is_expected.to be_empty }
    end

    context 'when some fields have values' do
      subject { described_class.new(offence_type: 'something') }
      it { is_expected.not_to be_empty }
    end
  end
end
