class AddCheckedToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :checked, :boolean
  end
end
