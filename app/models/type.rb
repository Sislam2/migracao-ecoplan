class Type < ActiveRecord::Base
  self.table_name = "tipos"
  self.primary_key = 'tipo'

  has_many :licenses, class_name: "License", foreign_key: "tipo"

  rails_admin do
    # ...
  end
end