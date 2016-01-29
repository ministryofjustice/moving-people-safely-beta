class AddPersonFieldsToEscort < ActiveRecord::Migration
  def change
    add_column :escorts, :family_name, :string
    add_column :escorts, :forenames, :string
    add_column :escorts, :date_of_birth, :date
    add_column :escorts, :sex, :string
    add_column :escorts, :prison_number, :string
    add_column :escorts, :nationality, :string
  end
end
