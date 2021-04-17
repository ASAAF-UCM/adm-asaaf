class RemoveImageDataFromMembers < ActiveRecord::Migration[6.1]
  def change
    remove_column :members, :image_data
  end
end
