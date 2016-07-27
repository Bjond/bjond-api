class CreateBjondServices < ActiveRecord::Migration
  def change
    create_table :bjond_services do |t|
      t.string :group_id
      t.string :endpoint

      t.timestamps null: false
    end
  end
end
