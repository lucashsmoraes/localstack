#!/bin/bash

# Verificar se as variáveis foram informadas
if [ -z "$FILE" ] || [ -z "$BUCKET" ]; then
  echo $FILE
  echo $BUCKET
  echo "As variáveis FILE e BUCKET devem ser informadas no docker-compose."
  exit 1
fi

# Função para criar o S3
create_s3_bucket() {
  echo "funçao create"
  echo $FILE
  echo $BUCKET

  echo "Verificar se o S3 já existe"
  bucket_exists=$(aws --endpoint-url=http://localhost:4566 s3 ls s3://$BUCKET)
  if [ -z "$bucket_exists" ]; then
    # Criar o S3 se ele não existir
    aws --endpoint-url=http://localhost:4566 s3 mb s3://$BUCKET
    echo "bucket criado com sucesso"
    aws --endpoint-url=http://localhost:4566 s3 ls s3://$BUCKET
  fi
}

# Função para fazer o upload de arquivos
upload_to_s3() {

  #Como no docker-compose eu estou criando um volume da pasta aws para etc/*** eu devo entrar primeiro
  # ai posso referênciar o arquivo para fazer o upload no s3
  cd /etc/localstack/init/ready.d
  echo "########################"
  ls

  # Fazer o upload dos arquivos para o S3
  aws --endpoint-url=http://localhost:4566 s3 cp ./files/$FILE s3://$BUCKET/$FILE
}

# Chamar as funções
create_s3_bucket
upload_to_s3
