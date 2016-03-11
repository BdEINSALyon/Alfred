class AddPaymentMethodToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :payment_method_id, :integer
  end
end
