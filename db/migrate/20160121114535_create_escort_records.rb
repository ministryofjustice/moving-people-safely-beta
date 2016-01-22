class CreateEscortRecords < ActiveRecord::Migration
  def change
    create_table :escort_records, id: :uuid, default: "uuid_generate_v4()" do |t|

      t.timestamps null: false
    end
  end
end
