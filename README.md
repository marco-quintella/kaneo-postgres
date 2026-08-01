# 📋 Kaneo + Postgres

[Kaneo](https://kaneo.app) — "All you need. Nothing you don't." Open source project management (kanban, tasks, time tracking, GitHub/GitLab sync) que roda na **imagem oficial** — sem build customizado, deploy em ~2min.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new?template=https://github.com/marco-quintella/kaneo-postgres)

> **Nota:** após publicar o template no marketplace (Dashboard → Templates → Publish), substitua o link acima pelo oficial gerado na publicação (`railway.com/new/template/<CODE>`).

## Stack

- **Kaneo 2.12** — imagem oficial `ghcr.io/usekaneo/kaneo` (Hono API + React web + nginx num container só)
- **Postgres 16** — plugin Railway (migrations do Drizzle rodam **automáticas no startup**)
- **BetterAuth** embutido no Kaneo (email/OTP, senha, GitHub SSO)

## O que vem configurado

- ✅ Container único — nginx (porta 5173) proxyando `/api` pro servidor Hono
- ✅ Migrations aplicadas automaticamente no boot (espera o banco ficar pronto)
- ✅ Healthcheck em `/api/health` pro Railway monitorar
- ✅ `AUTH_SECRET` persistente — sessões sobrevivem a restarts
- ✅ Redis/S3/SMTP **opcionais** — Kaneo funciona sem eles (fallback in-memory)

## Variáveis de ambiente

| Nome | Obrigatória | Descrição |
|------|-------------|-----------|
| `DATABASE_URL` | ✅ Sim | URL do Postgres — injetada pelo plugin Railway automaticamente |
| `PORT` | ✅ Sim | `5173` — o Railway roteia o healthcheck/tráfego por essa env var (o EXPOSE do Dockerfile **não** é usado; sem PORT o deploy falha no healthcheck) |
| `AUTH_SECRET` | ✅ Sim | `openssl rand -hex 32`. Se ausente, gera aleatório no boot e **sessões morrem a cada restart** |
| `KANEO_CLIENT_URL` | ⚠️ Recomendada | URL pública do app (ex: `https://${{RAILWAY_PUBLIC_DOMAIN}}`). Sem ela, cookies/links apontam pra `localhost:5173` |
| `GITHUB_OAUTH_CLIENT_ID` / `GITHUB_OAUTH_CLIENT_SECRET` | Não | SSO "Sign in with GitHub" (OAuth App) |
| `SMTP_HOST` / `SMTP_PORT` / `SMTP_USER` / `SMTP_PASSWORD` / `SMTP_FROM` | Não | Emails de convite/verificação. Sem SMTP, login por **email+senha** funciona normal (OTP por email só é usado com SMTP configurado) |
| `S3_ENDPOINT` / `S3_BUCKET` / `S3_ACCESS_KEY_ID` / `S3_SECRET_ACCESS_KEY` | Não | Upload de imagens em tasks/comentários (S3-compatível: R2, MinIO…) |
| `REDIS_URL` | Não | Pub/Sub de WebSockets — só necessário com **múltiplas réplicas** (fallback: in-memory) |

### No wizard do Railway (ao criar o template)

- `DATABASE_URL` → marcar como **referência do serviço Postgres** (`${{Postgres.DATABASE_URL}}`)
- `PORT` → default fixo `5173` (obrigatório — sem ele o healthcheck falha)
- `AUTH_SECRET` → usar **generator** (Railway gera valor aleatório)
- `KANEO_CLIENT_URL` → default `https://${{RAILWAY_PUBLIC_DOMAIN}}`

## Como funciona

1. Railway builda o wrapper Dockerfile (só copia a imagem oficial — build em segundos)
2. Provisiona o Postgres e injeta `DATABASE_URL`
3. Container sobe → entrypoint espera o banco, roda migrations do Drizzle, inicia nginx + API
4. Acesse a URL do serviço → crie sua conta → crie o primeiro workspace

## Como fazer deploy

1. Clique no botão **Deploy on Railway** acima
2. No wizard: confirme Postgres, `AUTH_SECRET` (gerado) e `KANEO_CLIENT_URL` (`https://${{RAILWAY_PUBLIC_DOMAIN}}`)
3. Aguarde o deploy (~2–3min na primeira vez — migrations no boot)
4. Abra a URL gerada e cadastre o primeiro usuário (vira owner)

### Setup local (Docker Compose)

```bash
cp .env.sample .env   # edite POSTGRES_PASSWORD, AUTH_SECRET, KANEO_CLIENT_URL
docker compose up -d
# → http://localhost:5173
```

## Custo estimado no Railway

| Serviço | Tier | Custo/mês |
|---|---|---|
| Kaneo (container) | Hobby (crédito $5 inclusos) | $0 com trial |
| Postgres | Free tier (500MB) | $0 |
| **Total** | | **$0** até bater limites do trial |

## Atualizando o Kaneo

O template pina a tag semver da imagem (ex: `2.12.1`). Pra atualizar:

1. Veja as releases em https://github.com/usekaneo/kaneo/releases
2. Edite a tag no `Dockerfile`
3. Re-deploy

## Links úteis

- [Documentação oficial](https://kaneo.app/docs/core) · [GitHub](https://github.com/usekaneo/kaneo) · [Discord](https://discord.gg/rU4tSyhXXU)

## Licença

MIT (Kaneo) — template wrapper sob MIT
