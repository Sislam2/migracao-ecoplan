class Entrepreneur < ActiveRecord::Base
  self.table_name = "empreendedores"
  self.primary_key = 'clienteid'

  belongs_to :address, class_name: "Address", foreign_key: "adressid"
  has_many :licenses, class_name: "License", foreign_key: "clienteid"

  attr_reader :path_documents

  def path_documents
    @path_documents ||="/media/rafael/win-ntfs/Backup-Ecoplan/backups/Arquivos/users/#{clienteid}/*"
    #Dir["/media/rafael/win-ntfs/Backup-Ecoplan/ecoplan_AE/backups/ecoplan/Arquivos/Arquivos/users/#{clienteid}/*"].select { |file| puts file }
  end

  # Dir.glob("*/*.txt") do |my_text_file|
  #   puts "working on: #{my_text_file}..."
  # end
  # Dir['path/to/dir/*'].select { |e| File.file?(e) }

  # Arquivos\users\{clienteid}\*
  # PASTA Arquivos\users
  # esta pasta contem uma pasta para cada empreendedor, o nome da pasta corresponde ao campo clienteID da tabela Empreendedores

  # Arquivos\users\{clienteid}\{iddoc}_licAmb.doc
  # Pasta de cada Empreendedores
  # dentro da pasta de cada empreendedor os documentos começam com um numero seguido de um underline, o numero corresponde ao ID
  # da tabela licensas que contém os registros todos tipos de documentos emitidos.

  # Demais pastas em Arquivos\*
  # pastas que contém os modelos de documentos e os formulários

  rails_admin do
    show do
      field :clienteid
      field :rz
      field :rz2
      field :address
      field :ativo
      field :licenses
      field :atividade
      field :path_documents
    end
  end
end