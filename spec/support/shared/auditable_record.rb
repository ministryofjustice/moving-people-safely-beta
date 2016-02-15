RSpec.shared_examples 'an auditable record' do
  subject { described_class.create }

  it { is_expected.to be_versioned }

  it 'has paper_trail configured correctly', versioning: true do
    expect(subject.versions.count).to eq 1
    expect(subject.versions.first.event).to eq 'create'
    expect(subject.versions.first.object_changes).not_to be_empty

    subject.touch_with_version
    expect(subject.versions.count).to eq 2
    expect(subject.versions.second.event).to eq 'update'
    expect(subject.versions.second.object_changes.keys).to include 'updated_at'

    subject.destroy
    expect(subject.versions.count).to eq 3
    expect(subject.versions.third.event).to eq 'destroy'
  end

  it 'assigns the correct item_id to a versioned object', versioning: true do
    expect(subject.id).to eq subject.versions.first.item_id
  end
end
