# Stage 1 - Build React App
FROM node:18 AS build

# Update npm to the latest version
RUN npm install -g npm@latest

WORKDIR /app
COPY package*.json ./
RUN npm ci

COPY . .

# Stage 2 - Serve with NGINX
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
