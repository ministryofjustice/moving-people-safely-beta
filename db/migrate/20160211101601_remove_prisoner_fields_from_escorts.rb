class RemovePrisonerFieldsFromEscorts < ActiveRecord::Migration
  def change
    remove_column :escorts, :family_name, :string
    remove_column :escorts, :forenames, :string
    remove_column :escorts, :date_of_birth, :date
    remove_column :escorts, :sex, :string
    remove_column :escorts, :prison_number, :string
    remove_column :escorts, :nationality, :string
  end
end
