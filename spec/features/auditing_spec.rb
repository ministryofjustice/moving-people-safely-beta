require 'rails_helper'

RSpec.feature 'auditing an escort', type: :feature do
  it 'assigns the current user to the whodunnit on an escorts version' do
    start_escort_form

    last_escort_version = escort.versions.last
    whodunnit = User.find(last_escort_version.whodunnit)

    expect(user).to eq whodunnit
  end
end
