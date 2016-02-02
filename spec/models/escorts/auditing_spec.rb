require 'rails_helper'

RSpec.describe 'Auditing an escort record' do
  it 'has paper_trail configured correctly', versioning: true do
    escort = create(:escort)
    expect(escort.versions.count).to eq 1
    expect(escort.versions.first.event).to eq 'create'
    expect(escort.versions.first.object_changes.count).to eq 9

    escort.update_attributes(family_name: 'Jones')
    expect(escort.versions.count).to eq 2
    expect(escort.versions.second.event).to eq 'update'
    expect(escort.versions.second.object_changes.keys).to include 'family_name'

    escort.destroy
    expect(escort.versions.count).to eq 3
    expect(escort.versions.third.event).to eq 'destroy'
  end
end
