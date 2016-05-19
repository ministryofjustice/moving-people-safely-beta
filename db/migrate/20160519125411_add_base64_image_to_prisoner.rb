class AddBase64ImageToPrisoner < ActiveRecord::Migration
  def change
    add_column :prisoners, :base_64_image, :text
  end
end
