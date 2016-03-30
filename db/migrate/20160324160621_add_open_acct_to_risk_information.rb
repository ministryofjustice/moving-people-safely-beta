class AddOpenAcctToRiskInformation < ActiveRecord::Migration
  def change
    add_column :risk_information, :open_acct, :boolean
  end
end
