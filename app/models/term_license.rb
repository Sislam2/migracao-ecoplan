class TermLicense < ActiveRecord::Base
  self.table_name = "condicoesprocessos"
  self.primary_key = 'seq'

  belongs_to :term, class_name: "Term", foreign_key: "condicoesid"
  belongs_to :license, class_name: "License", foreign_key: "licid"
  belongs_to :parent, class_name: "TermLicense", foreign_key: "parentid"
  belongs_to :user, class_name: "User", foreign_key: "conduserid"

  rails_admin do
    # ...
  end
end