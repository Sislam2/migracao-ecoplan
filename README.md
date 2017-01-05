# README

Projeto criado para importar os XMLs do ECOPLAN para o PostgresSQL e adicionado GEM rails_admin para visualizar os dados importados do banco de dados.

Rodar:
1. Colocar os XMLs na pasta "public/ecoplan/"
2. Rodar o "rake db:seed"
3. Criar as tabelas de controle e tipos de documentos manualmente ( copiar SQL do arquivo do seed )
4. Acessar http://localhost:3000/admin

