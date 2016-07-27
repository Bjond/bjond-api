class RenameEncryptionKeyColumn < ActiveRecord::Migration
  def change
    rename_column :bjond_registrations, :encryptionKey, :encrypted_encryption_key
  end
end
