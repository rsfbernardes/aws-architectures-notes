# Arquitetura: EC2 + EBS

Resumo
Este documento descreve os passos para criar uma instância EC2 com um volume EBS adicional, incluindo:
- Criação de instância
- Criação e anexação de EBS
- Automação com user-data
- Backups (snapshots) e recuperação
- Considerações de segurança

Visão de alto nível
- EC2 (t2.micro/t3.micro para testes)
- Volume EBS (gp3 ou gp2) para armazenamento de dados persistente
- Security Group restringindo SSH (porta 22) por IP e HTTP/HTTPS conforme necessário
- IAM Role mínima para permitir snapshots/CloudWatch (opcional)

Passos manuais (AWS Console / CLI)
1. Escolher AMI e tipo de instância:
   - AMI: Amazon Linux 2 / Ubuntu (verificar AMI ID para sua região).
2. Criar Security Group:
   - Permitir SSH de seu IP (ex: 203.0.113.5/32)
   - Permitir HTTP/HTTPS conforme necessário
3. Criar EBS:
   - aws ec2 create-volume --availability-zone us-east-1a --size 20 --volume-type gp3
4. Iniciar EC2 e anotar InstanceId e AvailabilityZone.
5. Anexar EBS:
   - aws ec2 attach-volume --volume-id vol-0123456789abcdef0 --instance-id i-0123456789abcdef0 --device /dev/sdf
6. No EC2 (ex.: Amazon Linux 2):
   - sudo mkfs -t ext4 /dev/xvdf
   - sudo mkdir /data
   - sudo mount /dev/xvdf /data
   - Adicionar /etc/fstab para montagem automática (use UUIDs via blkid)

Exemplo rápido AWS CLI (resumido)
- Criar volume:
  aws ec2 create-volume --size 20 --availability-zone us-east-1a --volume-type gp3
- Anexar volume:
  aws ec2 attach-volume --volume-id <VOLUME_ID> --instance-id <INSTANCE_ID> --device /dev/sdf

User-data (automação)
Veja scripts/ec2_user_data.sh para um exemplo de user-data que:
- Instala nginx
- Formata e monta o EBS se não estiver formatado
- Cria uma página inicial com hostname

Backups e snapshots
- Criar snapshot do volume:
  aws ec2 create-snapshot --volume-id <VOLUME_ID> --description "backup <data>"
- Para restaurar:
  - Criar novo volume a partir do snapshot e anexar à instância.

Boas práticas e lições aprendidas
- Use tags (Name, Project, Environment) para rastreabilidade.
- Evite formatar volumes com dados existentes sem checar.
- Sempre testar fstab antes de reiniciar para evitar instâncias inacessíveis.
- Monitorar I/O e métricas CloudWatch (throughput e IOPS) para ajustar tipo de volume.

Troubleshooting comum
- Erro ao montar: checar /dev/mapper e nomes de dispositivo (xvd* vs nvme*).
- Volume em Availability Zone diferente: o volume precisa estar na mesma AZ da instância para anexar.

Referências
- scripts/ec2_user_data.sh
- AWS Docs: EC2, EBS, Snapshots