class User < ActiveRecord::Base
  self.table_name = "users_ecoplan"
  self.primary_key = 'id'

  has_many :licenses, class_name: "License", foreign_key: "userid"

  rails_admin do
    # ...
  end
end