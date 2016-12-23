# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DB_COLUMNS_TYPE = {"xs:int"=> "integer","xs:long"=> "string", "xs:string"=> "string","xs:dateTime"=> "datetime","xs:decimal"=> "decimal", "xs:short"=>"string" }

xmls = Dir[Rails.root.join("public", "ecoplan","*")]

connection = ActiveRecord::Base.connection()

xmls.each do |xml|
  xml_readed = Nokogiri::XML(File.read(xml).gsub(/\n\t/, " ").gsub(/>\s*</, "><"))
  xml_readed.remove_namespaces!

  name_table = xml_readed.xpath('//choice/element')[0]["name"].downcase.to_sym
  #=> "EMAILS" --- NOME DA TABELA
  columns_table = xml_readed.xpath('//sequence').children.map{|column| [ column.attributes["name"].value, column.attributes["type"].value ] }
  #=> [["ID", "xs:int"], ["EMAIL", "xs:string"], ["FOR_PROC", "xs:long"]] --- COLUNAS E TIPOS

begin
  ActiveRecord::Migration.create_table(name_table, primary_key: false)
  columns_table.each do |column|
   ActiveRecord::Migration.add_column(name_table, column[0].downcase.to_sym, DB_COLUMNS_TYPE[column[1]].to_sym)
  end
rescue
  puts "ERROR CREATE TABLE #{name_table}"
end



  hash_by_xml = Hash.from_xml(xml_readed.xpath('//NewDataSet').to_xml)
  # {"NewDataSet"=>
  # {"EMAILS"=>
  #   [{"id"=>"EMAILS1", "rowOrder"=>"0", "ID"=>"0", "EMAIL"=>"protocolo.semmas@santacruz.rs.gov.br", "FOR_PROC"=>"9223372036854775807"},
  #    {"id"=>"EMAILS2", "rowOrder"=>"1", "ID"=>"1", "EMAIL"=>"atendimento.smmass@santacruz.rs.gov.br", "FOR_PROC"=>"9223372036854775807"}]}}
  if hash_by_xml.nil?
    puts "TABLE #{name_table} WITOUT RECORDS"
    next
  end
  rows = hash_by_xml["NewDataSet"].values.flatten

  name_table = hash_by_xml["NewDataSet"].keys.last.downcase

  rows.each do |row|
  begin
    names_colums = row.except!("id","rowOrder").keys.join(",")
    values_colums = row.except!("id","rowOrder").values.map {|str| "'#{str.to_s.gsub("'","''") unless str.blank?}'"}.join(',')
    connection.execute("insert into #{name_table} (#{names_colums}) values ( #{values_colums})")
  rescue
    puts "insert into #{name_table} (#{names_colums}) values ( #{values_columns})"
  end

  end

  connection.execute("CREATE TABLE tiposprocessos
  (
    id bigint NOT NULL,
    descricao character varying(50),
    enumunico smallint,
    alertadias bigint,
    alertadiascond bigint,
    alertaconf bigint,
    CONSTRAINT pk_ontiposprocessos PRIMARY KEY (id)
  )
  WITH (
    OIDS=FALSE
  );");

  connection.execute("INSERT INTO tiposprocessos VALUES (1, 'Licença Ambiental', 0, 150, 30, 3);
  INSERT INTO tiposprocessos VALUES (2, 'Alvará Florestal', 0, 30, 30, 3);
  INSERT INTO tiposprocessos VALUES (4, 'Autorização', 0, 30, 30, 3);
  INSERT INTO tiposprocessos VALUES (8, 'Infração', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (16, 'Notificação', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (32, 'Declaração', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (64, 'Certidão', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (128, 'Apreenção', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (256, 'Interdição', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (512, 'Poço Prévio', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (1024, 'Poço Definitivo', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (2048, 'Denúncia', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (4096, 'Solicitação de Serviço', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (8192, 'Indeferimento', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (16384, 'Isenção', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (32768, 'Poço Tamponamento', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (65536, 'Ofício', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (131072, 'Parecer', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (262144, 'Vistoria', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (524288, 'Memorando', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (1048576, 'Decisão Administrativa', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (2097152, 'Licença Sanitária', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (4194304, 'Termo de Compromisso', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (8388608, 'Contrato', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (16777216, 'Anuência', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (33554432, 'Laudo', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (67108864, 'Atestado', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (134217728, 'Genérico', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (268435456, 'Viabilidade', 0, 0, 0, 0);
  INSERT INTO tiposprocessos VALUES (536870912, 'Julgamento', 0, 0, 0, 0);
  ")

  puts "feitooooo"
end