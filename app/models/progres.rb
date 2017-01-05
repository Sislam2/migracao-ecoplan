class Progres < ActiveRecord::Base
  self.table_name = "andamentos"
  self.primary_key = 'id'

  has_many :licenses, class_name: "License", foreign_key: "andamentoid"

  rails_admin do
    # ...
  end
end