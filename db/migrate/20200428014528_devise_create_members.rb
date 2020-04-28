# frozen_string_literal: true

class DeviseCreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members, id: :uuid, default: 'gen_random_uuid()' do |t|
      # Info for ASAAF
      t.string  :name,                        null: false
      t.string  :surname1,                    null: false
      t.string :surname2
      t.date    :birthdate,                   null: false
      t.integer :id_document_type_id,         null: false
      t.date    :id_document_expiration_date, null: false
      t.string  :id_document_number,          null: false
      t.jsonb :image_data
      t.integer :member_number
      t.integer :member_type_id
      t.date    :member_since
      t.date    :last_active_member_confirmation
      t.string  :moodle_name

      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.timestamps null: false
    end

    create_table :id_document_types do |t|
      t.string  :name, null: false
    end

    create_table :member_types do |t|
      t.string  :name, null: false
    end

    add_index :members, :id_document_number
    add_index :members, :email, unique: true
    add_index :members, :member_number
    add_index :members, :reset_password_token, unique: true
    add_index :members, :confirmation_token,   unique: true
    add_index :members, :unlock_token,         unique: true

    add_foreign_key :members, :id_document_types
    add_foreign_key :members, :member_types
  end
end
