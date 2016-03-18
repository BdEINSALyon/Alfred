class Participant < ActiveRecord::Base
  belongs_to :payment_method
  validates_uniqueness_of :ticket_code

  def label
    "#{last_name.upcase} #{first_name}"
  end

  rails_admin do
    object_label_method do
      :label
    end
    import do
      include_all_fields
      mapping_key :ticket_code
    end
  end
end
