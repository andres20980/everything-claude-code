# Dockerfile estándar de Megacore (2026) para aplicaciones web estáticas y SPAs (Vite, React, HTML5)

# Etapa 1: Construcción (si existe package.json)
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
# Instalar dependencias si existe el archivo
RUN if [ -f package.json ]; then npm install; fi
COPY . .
# Compilar si existe script de build, de lo contrario copiar archivos a dist/
RUN if [ -f package.json ] && grep -q '"build"' package.json; then npm run build; else mkdir -p dist && cp -R * dist/ 2>/dev/null || true; fi

# Etapa 2: Servidor de Producción Nginx
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
