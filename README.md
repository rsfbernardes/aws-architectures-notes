# AWS-Architectures-Notes

Repositório de anotações e insights práticos sobre a criação de duas arquiteturas AWS:
- EC2 + EBS (instância virtual com volume de bloco)
- S3 + Lambda (armazenamento de objetos com processamento serverless)

Objetivo
- Registrar passo a passo, decisões arquiteturais, comandos e aprendizados enquanto você implementa e testa as arquiteturas.
- Servir como material de apoio para estudos e como base reutilizável em projetos futuros.
- Cumprir os critérios do desafio: documentação clara, repositório público com README detalhado e (opcional) imagens.

Conteúdo deste repositório
- README.md — este arquivo.
- docs/ — documentação por arquitetura, diagramas e notas.
- scripts/ — exemplos de user-data, funções Lambda e exemplos de Terraform.
- images/ — capturas de tela e diagramas (opcional).
- STUDY_LOG.md — registro cronológico das sessões e insights.
- CHECKLIST.md — checklist prático para a atividade.
- CONTRIBUTING.md — como adicionar suas notas e imagens.
- LICENSE — MIT.

Como usar este repositório (fluxo recomendado)
1. Leia os documentos em docs/ na sequência: docs/ec2-ebs.md → docs/s3-lambda.md → docs/diagrams.md.
2. Use os scripts em scripts/ como ponto de partida. Ajuste IDs de AMI, ARNs, nomes e regiões para sua conta.
3. Execute os passos em um ambiente controlado (conta de laboratório). Atenção aos custos ao deixar recursos rodando.
4. Registre no STUDY_LOG.md os tempos, erros e decisões para referência futura.
5. Faça commit das suas capturas em images/ e atualize os documentos com prints e observações.

Boas práticas e segurança
- Nunca compartilhe chaves de acesso. Use roles e profiles (AWS CLI / IAM roles).
- Teste em contas ou ambientes de baixo custo (conta de sandbox).
- Remova recursos quando não estiver usando para evitar cobranças.
- Use snapshots do EBS e versionamento para S3 quando apropriado.

Entrega / Checklist para submissão
- Verifique se o README está atualizado.
- Confirme que há pelo menos um arquivo em docs/ com passos reproduzíveis.
- (Opcional) Adicione screenshots em /images.
- Publique o repositório como público e copie o link para entregar o projeto.

Recursos e referências rápidas
- Console AWS: https://console.aws.amazon.com
- Documentação EC2 / EBS / S3 / Lambda — AWS Docs
- Exemplos de Terraform no diretório scripts/

Contato
- Autor / estudante: Rodrigo Bernardes (rsfbernardes)

-- Fim --
