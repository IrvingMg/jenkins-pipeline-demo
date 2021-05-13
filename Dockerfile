# Stage 1
FROM node:14-alpine as build-stage
WORKDIR /app
COPY webapp/package.json /app
RUN npm install
COPY webapp /app
RUN npm run build

# Stage 2
FROM nginx:1.18.0-alpine
COPY --from=build-stage /app/build /usr/share/nginx/html
