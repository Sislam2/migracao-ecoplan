class Attachment < ActiveRecord::Base
  self.table_name = "files"
  self.primary_key = 'fileid'

  rails_admin do
    # ...
  end
end