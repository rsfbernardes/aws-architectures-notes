# Arquitetura: S3 + Lambda

Resumo
Descrição de uma arquitetura onde:
- Objetos são enviados para um bucket S3
- Um evento S3 (PUT) aciona uma função Lambda
- Lambda processa o objeto (ex.: gerar miniatura, validar conteúdo, mover para outra chave)

Componentes
- S3 Bucket (com versioning e lifecycle opcional)
- Lambda function (ex.: Python 3.11)
- IAM Role para Lambda com permissões limitadas (s3:GetObject, s3:PutObject, logs:CreateLogStream, logs:PutLogEvents)
- (Opcional) SNS / SQS para desacoplamento e retries

Criando a Lambda (exemplo)
- Código exemplo: scripts/lambda_function.py
- Empacotar dependências (se houver) em um deployment package (.zip)
- Criar role:
  - Policy mínima: permitir acesso ao bucket alvo e CloudWatch Logs
- Criar trigger:
  - Na console S3 → Properties → Event notifications → adicionar evento PUT → acionar Lambda

Exemplo AWS CLI (resumido)
- Criar bucket:
  aws s3api create-bucket --bucket meu-bucket-exemplo --region us-east-1 --create-bucket-configuration LocationConstraint=us-east-1
- Criar role + policy (usando iam create-role, iam put-role-policy)
- Criar função Lambda (zip do código):
  aws lambda create-function --function-name process-s3-put --runtime python3.11 --role <ROLE_ARN> --handler lambda_function.lambda_handler --zip-file fileb://deploy.zip

Deploy com SAM / Serverless / Terraform
- Usar SAM para facilitar empacotamento e deploy locais (sam build / sam deploy).
- Em Terraform, usar aws_lambda_function, aws_s3_bucket_notification e aws_iam_role.

Boas práticas e considerações
- Evitar funções longas; para cargas maiores, enviar evento para SQS e processar de forma batch.
- Manejar retries: Lambda com trigger S3 não tem DLQ nativo — considere SNS/SQS.
- Limitar permissões da role (principle of least privilege).
- Habilitar versioning em S3 para capacidade de recuperação.

Logs e monitoramento
- CloudWatch Logs para a função Lambda
- CloudWatch Metrics: invocações, erros, duração
- X-Ray para tracing (opcional)

Erros comuns
- Permissões insuficientes (role não permite leitura do bucket).
- Nome do handler incorreto ao criar a função.
- Tamanho do pacote ultrapassa limite — usar layers ou ECR para funções maiores.

Referências
- scripts/lambda_function.py
- AWS Docs: Lambda, S3 Notifications, IAM