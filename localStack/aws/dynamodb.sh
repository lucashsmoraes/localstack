#!/bin/bash

# Verifica se as variáveis foram passadas corretamente
verify_variables() {
  if [ -z "$TABLE_NAME" ] || [ -z "$ENDPOINT" ] || [ -z "$AWS_REGION" ]; then
  echo $AWS_REGION
  echo $TABLE_NAME
  echo $ENDPOINT
  echo "As variáveis TABLE_NAME e ENDPOINT devem ser informadas no docker-compose."
  exit 1
  fi
}

# Verifica se a tabela já existe
check_table_exists() {
  result=$(aws --region $AWS_REGION --endpoint-url $ENDPOINT dynamodb list-tables)
  if [ $? -ne 0 ]; then
    echo "Erro ao verificar se a tabela existe."
    exit 1
  fi

  if [[ $result == *"$TABLE_NAME"* ]]; then
    echo "A tabela $TABLE_NAME já existe."
  else
    create_table
  fi
}

# Cria uma tabela no DynamoDB
create_table() {
  #Como no docker-compose eu estou criando um volume da pasta aws para etc/*** eu devo entrar primeiro no caminho abaixo
  # ai posso referênciar o arquivo para fazer o upload no s3
  cd /etc/localstack/init/ready.d/schema
  echo "########################"
  ls

  for filename in *.json; do
    awslocal dynamodb create-table --cli-input-json file://${filename}
  done
  if [ $? -eq 0 ]; then
    echo "A tabela $TABLE_NAME foi criada com sucesso."
  else
    echo "Erro ao criar a tabela $TABLE_NAME."
    exit 1
  fi
}

upload_data() {
  cd /etc/localstack/init/ready.d/data
  echo "########################"
  ls

  for filename in *.json; do
    aws dynamodb batch-write-item --request-items file://${filename} --endpoint-url $ENDPOINT --region $AWS_REGION
  done
  aws dynamodb --region $AWS_REGION scan --table-name $TABLE_NAME --endpoint-url $ENDPOINT
}

# Executa as funções
verify_variables
check_table_exists
upload_data
