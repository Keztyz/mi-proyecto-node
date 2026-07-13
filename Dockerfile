# Etapa 1: Builder (Construcción)
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# Si usas TypeScript, descomenta la siguiente línea:
# RUN npm run build

# Etapa 2: Production (Ejecución ligera)
FROM node:20-alpine AS production
WORKDIR /app
COPY package*.json ./
# Solo instalamos dependencias necesarias para ejecutar, no para compilar
RUN npm ci --only=production
# Copiamos lo necesario de la etapa anterior
COPY --from=builder /app ./

EXPOSE 3000
CMD ["node", "src/app.js"]