FROM node:16 AS webbuilder

WORKDIR /build

COPY . .

# RUN apt -y update && apt -y install git make gcc g++ yarn

RUN npm install && npm run build

FROM nginx:alpine AS webserver

COPY --from=webbuilder /build/dist /usr/share/nginx/html
COPY --from=webbuilder /build/build/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

RUN ["nginx", "-t"]

CMD ["nginx", "-g", "daemon off;"]