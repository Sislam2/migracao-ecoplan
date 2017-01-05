class EnviromentActivity < ActiveRecord::Base
  self.table_name = "licambientais"
  self.primary_key = 'id'

  belongs_to :parent, class_name: "EnviromentActivity", foreign_key: "parent"
  belongs_to :file, class_name: "Attachment", foreign_key: "fileid" # Formulario 500 = form_ilai_LO.doc
  belongs_to :fileorg, class_name: "Attachment", foreign_key: "fileorg" # Formulario 500 = form_ilai_LO.doc

  has_many :licenses, class_name: "License", foreign_key: "codigo", primary_key: "codigo"

  rails_admin do
    # ...
  end
end