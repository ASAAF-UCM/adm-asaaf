class CreateRoleTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :role_types do |t|
      t.string :role_name
    end
  end
end
