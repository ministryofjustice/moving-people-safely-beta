RSpec.shared_examples 'a record with a uuid as a primary key' do
  subject { create_from_constant(described_class) }

  context 'on create' do
    it 'generates a V4 UUID as a primary key' do
      expect(subject.id).to match TestHelper::UUID_REGEX
    end
  end
end
