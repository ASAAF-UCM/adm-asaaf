# frozen_string_literal: true

class CreateRoleAllocations < ActiveRecord::Migration[6.0]
  def change
    create_table :role_allocations do |t|
      t.belongs_to :role_type, null: false, foreign_key: true
      t.belongs_to :member, type: :uuid, null: false, foreign_key: true
      t.boolean :is_active

      t.timestamps
    end
  end
end
