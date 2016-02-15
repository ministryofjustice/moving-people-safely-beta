require 'rails_helper'

RSpec.describe RiskInformation, type: :model do
  it_behaves_like 'an auditable record'
  it_behaves_like 'a record with a uuid as a primary key'
end
