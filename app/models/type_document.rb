class TypeDocument < ActiveRecord::Base
  self.table_name = "tiposprocessos"
  self.primary_key = 'id'

  rails_admin do
    # ...
  end
end