class Registration < ActiveRecord::Base
  self.table_name = "matriculas"
  self.primary_key = 'id'

  belongs_to :address, class_name: "Address", foreign_key: "adressid"

  rails_admin do
    # ...
  end
end