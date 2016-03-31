class CreateYurplans < ActiveRecord::Migration
  def change
    create_table :yurplans do |t|
      t.string :name
      t.string :client_id
      t.string :client_secret
      t.string :event_id

      t.timestamps null: false
    end
  end
end
