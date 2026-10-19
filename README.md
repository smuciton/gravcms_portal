# GravCMS Portal - Cloudflare Demos

Sitio GravCMS (tema **Saturn**) usado como herramienta para probar funcionalidades de Cloudflare (CDN/Cache, WAF, Rate Limiting, Bot Management, Turnstile, Workers, etc.).

Referencia: https://emea01.cloudinstance.info/

## Estructura

```
.
├── Dockerfile            # PHP 8.3 + Apache + Grav core + tema/plugins via GPM
├── docker-compose.yml
└── user/                 # Lo único versionado de Grav
    ├── config/           # site.yaml, system.yaml, plugins/
    └── pages/
        ├── 01.usecases/  # Listado tipo blog (home)
        ├── 02.about/
        └── 03.contact/   # Formulario (pruebas de POST/WAF/Turnstile)
```

Temas y plugins no se versionan; se instalan en el build con `bin/gpm`.

## Ejecutar en local

```bash
docker compose up -d --build
```

Abrir http://localhost:8080 (sitio) y http://localhost:8080/admin (crear el usuario administrador en el primer acceso).

## Instalación sin Docker

1. Descargar Grav: https://getgrav.org/download/core/grav/latest y descomprimir.
2. Copiar `user/config` y `user/pages` de este repo sobre la carpeta `user/` de Grav.
3. Desde la raíz de Grav: `bin/gpm install -y saturn form email pagination feed taxonomylist error problems admin`
