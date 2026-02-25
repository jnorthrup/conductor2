# Conductor One‑Pager (Dense Methodology)

This document provides a **single‑page** view of the full Conductor methodology while keeping the LLM context minimal. All substantive content is stored as tokens in `conductor/methodology_token_map.json`. The tokens are referenced below; an agent can retrieve the full text with `claude -p token-get <TOKEN>`.

## Tokens
- **T001** – Tracks overview
- **T002** – Installer spec
- **T003** – Installer plan
- **T004** – Full methodology (English + Chinese)

## Core command (remains literal English)
```
conductor implement
```

> *Note*: The `conductor implement` command is deliberately left as plain English to avoid tokenization of symbols that may cause parsing issues.

*To view any section, run* `claude -p token-get <TOKEN>` *e.g.* `claude -p token-get T004`.
