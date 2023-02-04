### Esse projeto irá criar dynamodb e fazer upload de um metadado default para teste

### Pré requisito
- AWS ClI instalado
- Docker instalado

### Comandos Básicos dynamodb

- Verificar se tem dado no dynamodb
  ``aws dynamodb --region us-east-1 scan --table-name <nome da tabela> --endpoint-url http://localhost:4566``

### Ponto de atenção: integração

- Para acessar os recurso criado no container localstack
  - configurar aws credentials
  - ``aws configure``
  - Preencher os seguintes campos
  - ``AWS Access Key ID: local``
  - ``AWS Secret Access Key: local``
  - ``Default region name: us-east-1``
  - ``Default output format: json``

  
