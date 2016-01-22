require 'rails_helper'

RSpec.describe Escort, type: :model do
  context 'on create' do
    it 'generates a V4 UUID as a primary key' do
      escort = described_class.create
      expect(escort.id).to match TestHelper::UUID_REGEX
    end
  end
end
