require 'rails_helper'

RSpec.describe 'Auditing an escort record' do
  subject { create(:prisoner) }

  it 'has paper_trail configured correctly', versioning: true do
    expect(subject.escort.versions.count).to eq 1
    expect(subject.versions.count).to eq 1
    expect(subject.versions.first.event).to eq 'create'
    expect(subject.versions.first.object_changes).not_to be_empty

    subject.update_attributes(family_name: 'Jones')
    expect(subject.versions.count).to eq 2
    expect(subject.versions.second.event).to eq 'update'
    expect(subject.versions.second.object_changes.keys).to include 'family_name'

    subject.destroy
    expect(subject.versions.count).to eq 3
    expect(subject.versions.third.event).to eq 'destroy'
  end

  it 'assigns the correct item_id to a versioned escort', versioning: true do
    escort = create(:escort)
    expect(escort.id).to eq escort.versions.first.item_id
  end
end
