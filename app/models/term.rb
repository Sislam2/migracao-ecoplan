class Term < ActiveRecord::Base
  self.table_name = "condicoes"
  self.primary_key = 'id'

  belongs_to :license, class_name: "License", foreign_key: "licid"

  rails_admin do
    # ...
  end
end