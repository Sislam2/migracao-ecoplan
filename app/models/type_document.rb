class TypeDocument < ActiveRecord::Base
  self.table_name = "tiposprocessos"
  self.primary_key = 'id'

  has_many :types, class_name: "Type", foreign_key: "licensa"

  rails_admin do
    # ...
  end
end