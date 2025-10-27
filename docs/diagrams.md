# Diagramas e representação das arquiteturas

Sugestões de diagramas
- Diagrama simples EC2+EBS:
  - EC2 instance ↔ EBS volume
  - Security Group → portas SSH/HTTP
- Diagrama S3+Lambda:
  - User → S3 bucket → evento → Lambda → (destino: S3/db/other service)
  - Adicionar IAM Role e CloudWatch

Ferramentas recomendadas
- draw.io / diagrams.net — desenhar diagramas e exportar PNG/SVG.
- PlantUML — diagramas em texto (útil para versionamento).
- Miro / Lucidchart — colaboração.

Armazenamento
- Coloque imagens exportadas em /images com nomes descritivos, ex.: images/ec2-ebs-architecture.png
- Atualize este arquivo com links relativos às imagens e anotações sobre o diagrama.

Exemplo PlantUML (padrão)
@startuml
actor User
node "S3 Bucket" as S3
node "Lambda" as L
User -> S3 : PUT Object
S3 -> L : Event Notification
L -> S3 : PUT Object (processed)
@enduml

(Colar seu PNG/SVG em /images e referenciar aqui)