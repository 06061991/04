# stage 1 : build Angular application
FROM node:18.20.7-alpine AS build
RUN npm install -g @angular/cli@16.2
WORKDIR /usr/src/app
 COPY package*.json  ./
 RUN npm install --legacy-peer-deps
 COPY . .
 RUN ng build
#stage 2 : run
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /usr/src/app/dist/angularschool   /usr/share/nginx/html
EXPOSE 80
