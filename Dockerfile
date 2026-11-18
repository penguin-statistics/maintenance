# Builder: Node.js 24 LTS (supported until 2028-04), pinned by digest.
# Only used to produce static assets; nothing from this stage ships except /build/dist.
FROM node:24.22.1-alpine@sha256:06d7adf3e0ef61a13f1d28682726366f97a15aa1888c934d3ecec86c33918b53 AS webbuilder

WORKDIR /build

COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund

COPY . .
RUN npm run build

# Runtime: Caddy (the version of the box's edge Caddy), pinned by digest. It serves the page on :80, without TLS,
# HTTP/2 or HTTP/3: the box's edge Caddy terminates TLS in front of it. Runs as an unprivileged user; the binary has
# cap_net_bind_service for :80.
FROM caddy:2.11.7-alpine@sha256:e70b164da81ef698b3ad19af799ea6086ce6d9e48ed4079eb9fe26f6fbf14ee5 AS webserver

COPY --from=webbuilder /build/dist /srv
COPY --from=webbuilder /build/build/Caddyfile /etc/caddy/Caddyfile
RUN ["caddy", "validate", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]

USER 65534:65534
EXPOSE 80

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
