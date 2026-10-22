# Builder: Node.js 24 LTS (supported until 2028-04), pinned by digest.
# Only used to produce static assets; nothing from this stage ships except /build/dist.
FROM node:24.22.1-alpine@sha256:06d7adf3e0ef61a13f1d28682726366f97a15aa1888c934d3ecec86c33918b53 AS webbuilder

WORKDIR /build

COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund

COPY . .
RUN npm run build

# Runtime: official nginx 1.30.x stable, pinned by digest.
# Kept on the official (root-master, listens on :80) image instead of
# nginx-unprivileged (:8080) so the manifests chart (containerPort/targetPort 80)
# and every Service/Ingress that falls back to maintenance keep working unchanged.
FROM nginx:1.30.6-alpine@sha256:47928bf67eb62a1863cb08d9ecb52d3e704304ba614eaee17884204677702951 AS webserver

COPY --from=webbuilder /build/dist /usr/share/nginx/html
COPY --from=webbuilder /build/build/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

RUN ["nginx", "-t"]

CMD ["nginx", "-g", "daemon off;"]
