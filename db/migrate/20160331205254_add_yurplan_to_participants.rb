class AddYurplanToParticipants < ActiveRecord::Migration
  def change
    add_reference :participants, :yurplan, index: true, foreign_key: true
  end
end
