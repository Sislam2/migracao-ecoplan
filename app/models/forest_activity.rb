class ForestActivity < ActiveRecord::Base
  self.table_name = "licflorestais"
  self.primary_key = 'id'

  belongs_to :file, class_name: "Attachment", foreign_key: "fileid" # Formulario 500 = form_ilai_LO.doc
  belongs_to :fileorg, class_name: "Attachment", foreign_key: "fileorg" # Formulario 500 = form_ilai_LO.doc
  belongs_to :document_type, class_name: "Type", foreign_key: "tipo"

  has_many :licenses, class_name: "License", foreign_key: "codigo", primary_key: "codigo"

  rails_admin do
    # ...
  end
end