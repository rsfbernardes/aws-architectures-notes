# Checklist prático para cada laboratório

Antes de iniciar
- [ ] Criar/usar perfil AWS CLI com credenciais seguras
- [ ] Verificar região e quotas
- [ ] Criar tags padrão (Project/Env/Owner)

Durante o laboratório
- [ ] Documentar comandos e outputs importantes
- [ ] Fazer testes controlados (upload/download, reboot)
- [ ] Tomar screenshots de telas importantes (opcional)

Encerramento
- [ ] Fazer snapshot/backup se quiser preservar estado
- [ ] Remover recursos não necessários (terminate EC2, delete volumes/buckets)
- [ ] Atualizar STUDY_LOG.md com resultados

Segurança
- [ ] Verificar políticas IAM aplicadas
- [ ] Restringir Security Group a IPs ou redes internas