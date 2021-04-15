class CreateMemberSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :member_settings do |t|
      t.uuid :member_id
      t.string :locale

      t.timestamps
    end

  add_foreign_key :member_settings, :members
  end
end
