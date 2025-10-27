# Registro de Estudo (Study Log)

Use este arquivo para registrar o que foi feito em cada sessão. Modelo de entrada:

- Data: 2025-10-27
  - Duração: 1h30
  - Arquitetura: EC2 + EBS
  - Atividades:
    - Criada instância EC2 (Amazon Linux 2).
    - Criado e anexado volume EBS de 20GB.
    - Teste de mount e persistência via /etc/fstab.
  - Erros encontrados:
    - Device name diferente (/dev/xvdf vs /dev/nvme1n1).
  - Insights / ações futuras:
    - Usar UUID em /etc/fstab para evitar problemas com nomes de dispositivos.
    - Automatizar criação via Terraform.

- Data: 2025-10-28
  - Duração: 2h
  - Arquitetura: S3 + Lambda
  - Atividades:
    - Implementado handler Lambda para copiar objeto a outro prefixo.
    - Configurado trigger S3 e testado upload.
  - Erros encontrados:
    - Permissão iam: s3:GetObject faltando.
  - Insights:
    - Criar policy mínima e testar antes.