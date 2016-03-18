class IndexTicketCodeToParticipants < ActiveRecord::Migration
  def change
    add_index :participants, :ticket_code
  end
end
