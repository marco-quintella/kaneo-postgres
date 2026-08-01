# Kaneo — wrapper sobre a imagem oficial publicada pelo projeto.
#
# A imagem ghcr.io/usekaneo/kaneo já empacota o app completo (nginx + API):
#   - Porta 5173 (EXPOSE) — nginx serve o web app e proxy /api pro Hono
#   - Migrations do Drizzle rodam AUTOMATICAMENTE no startup (runStartupTasks)
#   - Substituição de KANEO_* placeholders no bundle acontece no boot (env.sh)
#
# Não rebuildamos o app: o upstream publica imagem estável semanalmente
# (tags semver, ex: 2.12.1). Pino explícito = deploys reproduzíveis.
# Pra atualizar: bump da tag abaixo e re-deploy.
FROM ghcr.io/usekaneo/kaneo:2.12.1

# EXPOSE explícito é OBRIGATÓRIO: o Railway detecta a porta do serviço pelo
# EXPOSE do Dockerfile (não herda da imagem base via FROM). Sem isso o
# healthcheck é feito na porta errada e o deploy falha.
EXPOSE 5173
