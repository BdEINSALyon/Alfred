ActiveAdmin.register Participant do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :first_name, :last_name, :ticket_code, :payment_method_id
  active_admin_import

end
