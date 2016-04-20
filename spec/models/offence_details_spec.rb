require 'rails_helper'

RSpec.describe OffenceDetails, type: :model do
  it_behaves_like 'an auditable record'
  it_behaves_like 'a record with a uuid as a primary key'
  it { is_expected.to belong_to :offences }
end
