class AddRegistrationIdToBjondService < ActiveRecord::Migration
  def change
    add_column :bjond_services, :registration_id, :string
  end
end
