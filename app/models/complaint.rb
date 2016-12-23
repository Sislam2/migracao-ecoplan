class Complaint < ActiveRecord::Base
  self.table_name = "denuncias"
  self.primary_key = 'id'

  belongs_to :license, class_name: "License", foreign_key: "licid"

  rails_admin do
    # ...
  end
end