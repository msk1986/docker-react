FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# 本番環境のサーバーではbuildしたものだけが必要
# コピー先はhttps://hub.docker.com/_/nginxのドキュメントを参照
COPY --from=builder /app/build /usr/share/nginx/html

