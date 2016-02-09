class ChangeItemIdOnVersionsTable < ActiveRecord::Migration
  def change
    remove_column :versions, :item_id
    add_column    :versions, :item_id, :uuid, null: false
  end
end
