class License < ActiveRecord::Base
  self.table_name = "licensas"
  self.primary_key = 'id'

  attr_reader :file_path_document

  def file_path_document
    @file_path ||= entrepreneur.path_documents+"#{id}_*"
    Dir[@file_path]
  end

  #column status
  STATUS =[
    [1, "Aberta"],
    [2,"Em Vigor"],
    [4,"Vencida"],
    [8,"Cancelada"],
    [16,"Indeferida"],
    [32,"Substituida"],
    [64,"Isentada"],
    [128,"Atividade Encerrada"],
    [256,"Cassada"],
    [512,"Suspensa"]
  ].freeze

  #column completed
  COMPLETED = [
    [1,"Criado pelo Empreendedor e não Enviado"],
    [2,"Criado pelo Empreendedor e Enviado"],
    [16,"Criado pelo Empreendedor e aceito por um Operador"],
    [4,"Criado pelo Operador"],
    [8,"Criado mas ainda não salvo no Cadastro Geral"]
  ].freeze

  belongs_to :user, class_name: "User", foreign_key: "userid"
  belongs_to :parent, class_name: "License", foreign_key: "parentid"
  belongs_to :address, class_name: "Address", foreign_key: "adressid"
  belongs_to :file, class_name: "Attachment", foreign_key: "fileid" # Formulario 500 = form_ilai_LO.doc
  belongs_to :entrepreneur, class_name: "Entrepreneur", foreign_key: "clienteid"
  belongs_to :document, class_name: "TypeDocument", foreign_key: "licensa"
  belongs_to :document_type, class_name: "Type", foreign_key: "tipo"
  belongs_to :progress, class_name: "Progress", foreign_key: "andamentoid"

  rails_admin do
    show do
      field :enumnr
      field :id
      field :codigo
      field :fileid
      field :clienteid
      field :document
      field :document_type
      field :status
      field :enum
      field :dataabertura
      field :dataativacao
      field :datavencimento
      field :gpslat
      field :gpslong
      field :licensastr
      field :alerted
      field :obs
      field :protocolonr
      field :protocolodata
      field :user
      field :parent
      field :localfisico
      field :dadosadicionais
      field :progress
      field :tecnicoid
      field :address
      field :completed
      field :removeddate
      field :processonr
      field :processodata
      field :file_path_document
    end
  end
end