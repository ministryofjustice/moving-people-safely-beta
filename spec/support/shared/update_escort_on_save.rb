RSpec.shared_examples 'a record that updates the escort on save' do
  let(:escort) { create(:escort) }
  subject { described_class.create(escort: escort) }

  context 'on save' do
    it 'updates the associated escort' do
      escort_updated_at = subject.escort.updated_at
      subject.touch_with_version
      expect(subject.escort.updated_at).to be > escort_updated_at
    end
  end
end
