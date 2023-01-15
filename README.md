# localstack

### Comandos Básicos S3

- Criar Bucket S3
  ``aws --endpoint-url=http://localhost:4566 s3 mb s3://mybucket``
- Listar bucket S3
  ``aws --endpoint-url=http://localhost:4566 s3 ls s3://mybucket``

### Ponto de atenção: comunicação entre containers

- Para acessar os recurso criado no container localstack através do jupter devemos seguir alguns passos
  - configurar aws credentials
  - ``aws configure``
  - Preencher os seguintes campos
  - ``AWS Access Key ID: local``
  - ``AWS Secret Access Key: local``
  - ``Default region name: us-east-1``
  - ``Default output format: json``
  
##### Essas cofigurações deve seguir a mesmas adicionadas no docker compose, conforme imagem abaixo:
![img.png](imgs/img.png)
  - no terminal do jupter digitar os seguintes comandos conforme o nome do container:
  - ``aws --endpoint-url=http://local:4566 s3 mb s3://mybucket``
  - o seguinte comando vai listar os bucket
  - ``aws --endpoint-url=http://local:4566 s3 ls s3://mybucket``

#### A imagem seguinte demostra como deve ser a resposta
![img.png](imgs/img2.png)