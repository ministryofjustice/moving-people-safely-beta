require 'rails_helper'

RSpec.describe Prisoner, type: :model do
  it_behaves_like 'an auditable record'
  it_behaves_like 'a record with a uuid as a primary key'
  it_behaves_like 'a record that updates the escort on save'
end
