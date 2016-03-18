class Participant < ActiveRecord::Base
  belongs_to :payment_method

  def label
    "#{last_name.upcase} #{first_name}"
  end

  rails_admin do
    object_label_method do
      :label
    end
  end
end
