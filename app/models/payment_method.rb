class PaymentMethod < ActiveRecord::Base
  has_many :participants
end
