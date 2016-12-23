class Address < ActiveRecord::Base
  self.table_name = "adress"
  self.primary_key = 'adressid'

  rails_admin do
    # ...
  end
end