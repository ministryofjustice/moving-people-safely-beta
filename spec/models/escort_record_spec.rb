require 'rails_helper'

RSpec.describe EscortRecord, type: :model do
  context 'on create' do
    it 'generates a V4 UUID as a primary key' do
      escort_record = described_class.create
      expect(escort_record.id).to match TestHelper::UUID_REGEX
    end
  end
end
