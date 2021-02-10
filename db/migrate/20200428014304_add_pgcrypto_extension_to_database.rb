class AddPgcryptoExtensionToDatabase < ActiveRecord::Migration[6.0]
  def up
    exec_query('CREATE EXTENSION IF NOT EXISTS pgcrypto;')
  end

  def down
    exec_query('DROP EXTENSION IF EXISTS pgcrypto;')
  end
end
