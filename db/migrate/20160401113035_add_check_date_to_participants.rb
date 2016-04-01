class AddCheckDateToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :check_date, :datetime
  end
end
