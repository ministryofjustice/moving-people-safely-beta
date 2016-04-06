require 'rails_helper'

RSpec.describe Healthcare, type: :model do
  it_behaves_like 'an auditable record'
  it_behaves_like 'a record with a uuid as a primary key'
  it_behaves_like 'a record that updates the escort on save'
  it { is_expected.to have_many(:medications) }
end
