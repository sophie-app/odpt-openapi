# ODPT OpenAPI

OpenAPI specification of ODPT API

## About ODPT API

- [Official Document](https://developer.odpt.org/documents)
- [Datasets](https://ckan.odpt.org/dataset)

## Development

### Requirements

- Node.js
- pnpm

### Setup

1. Install dependencies

```bash
pnpm i
```

2. (Optional) Install VSCode Extension

```bash
pnpm tsp code install
```

3. Start TypeSpec watcher and Document server

```bash
pnpm dev
```

Document page will be available at [`http://127.0.0.1:8080`](http://127.0.0.1:8080)

### Scripts

- `pnpm dev`: Run TypeSpec watcher and Document Server
- `pnpm build`: Compile TypeSpec and Build document page
- `pnpm check`: Check TypeSpec format and OpenAPI lint
- `pnpm fix`: Fix TypeSpec format
