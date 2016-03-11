class RemoveTimestampsFromParticipants < ActiveRecord::Migration
  def change
    remove_column :participants, :created_at, :string
    remove_column :participants, :updated_at, :string
  end
end
