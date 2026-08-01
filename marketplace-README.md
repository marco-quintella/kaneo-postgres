# Deploy and Host Kaneo on Railway

## About Hosting

Railway provides a modern, streamlined platform for deploying web applications and databases. This template bundles **Kaneo** — open source project management ("All you need. Nothing you don't.") — running the official `ghcr.io/usekaneo/kaneo` image with a managed Postgres database, configured to work together out of the box.

## Why Deploy

Deploying this template gives you a complete self-hosted project management suite in ~2 minutes:

- **Kanban boards, tasks & time tracking** — full Linear/Jira alternative with Backlog, Board, List and Gantt views
- **Team collaboration** — workspaces, members, invitations, labels, comments, notifications (real-time via WebSockets)
- **GitHub/GitLab sync** — optional SSO sign-in and repository integration when you add OAuth credentials
- **Zero-build deploy** — the official Kaneo image is used as-is; migrations run automatically at startup
- **Production-ready defaults** — healthcheck endpoint (`/api/health`) for Railway monitoring and restart-on-failure policy

## Common Use Cases

- **Self-hosted project management** — keep your data on your own infrastructure, no vendor lock-in
- **Startup task tracking** — free Kanban/issue tracker without per-seat pricing
- **Team collaboration** — workspaces with members, invitations and role-based access
- **Production deployment** — official image, auto-migrations, persistent sessions across restarts

## Dependencies for

This template requires:

### Deployment Dependencies

- **Postgres** — add the Postgres service in the Railway dashboard; the `DATABASE_URL` connection string is injected automatically
- **`PORT`** — fixed to `5173` (the image's exposed port; Railway routes healthchecks/traffic by this variable)
- **`AUTH_SECRET`** — generate one with `openssl rand -hex 32`; the Railway deploy wizard will prompt you for it (sessions persist across restarts only with a stable secret)
- **`KANEO_CLIENT_URL`** — your public URL (defaults to `https://${{RAILWAY_PUBLIC_DOMAIN}}`); used for auth cookies and redirects

## Getting Started

1. Click **Deploy on Railway**
2. In the deploy wizard, provide the required variables (`AUTH_SECRET`, `PORT`, `KANEO_CLIENT_URL`)
3. Add the Postgres service — Railway injects `DATABASE_URL` automatically
4. Open the generated domain and create your first account (becomes workspace owner)

## Next Steps

- **Invite your team** — add members and set up workspace roles
- **Enable GitHub SSO** — create an OAuth App and set `GITHUB_OAUTH_CLIENT_ID`/`GITHUB_OAUTH_CLIENT_SECRET`
- **Add email notifications** — configure `SMTP_*` variables for invites and verification codes
- **Custom domain** — add one to your Railway service

## License

MIT (Kaneo) — template wrapper under MIT

---
<!-- IMPORTANT: the six headings below are MANDATORY for Railway marketplace
     acceptance (publish fails without them). Do not remove or rename:
     "# Deploy and Host", "## About Hosting", "## Why Deploy",
     "## Common Use Cases", "## Dependencies for", "### Deployment Dependencies".
     This is the MARKETPLACE overview — separate from the repo README. -->
