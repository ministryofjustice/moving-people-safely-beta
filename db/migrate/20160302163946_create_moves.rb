class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.uuid   :escort_id
      t.string :origin
      t.string :destination
      t.date :date_of_travel
      t.string :reason

      t.timestamps null: false
    end
  end
end
