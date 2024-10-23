# OPDT OpenAPI

## Development

### Requirements

- Node.js
- pnpm

### Setup

1. Install dependencies

```bash
pnpm i
```

2. Start Typespec watcher and documentation server from openapi

selectedAPIName is the name of `openapi.${selectedAPIName}.yaml`

```bash
NAME=${selectedAPIName} pnpm dev
```

### Scripts

- `pnpm dev` - 2. Start Typespec watcher and documentation server from openapi
- `pnpm build` - Build the tsp files
- `pnpm lint` - Lint the tsp files and openapi files
