class AddHostAndIpToBjondRegistrations < ActiveRecord::Migration
  def change
    add_column :bjond_registrations, :host, :string
    add_column :bjond_registrations, :ip, :string
  end
end
