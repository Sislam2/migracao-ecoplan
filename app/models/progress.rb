class Progress < ActiveRecord::Base
  self.table_name = "andamentos"
  self.primary_key = 'id'

  rails_admin do
    # ...
  end
end