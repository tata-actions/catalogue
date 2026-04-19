#Thing's	Included in node:20?	Notes
#1.Base OS (Linux)	✅	Debian/Alpine
#2.Node.js 20 software	✅	Pre-installed
#3.npm	✅	Comes with Node
#4.Your code	❌	You add using COPY
#5.Node modules

FROM node:20-alpine3.22 AS build

WORKDIR /opt/server
COPY package.json package-lock.json* ./
RUN npm ci --only=production
COPY *.js ./

FROM node:20-alpine3.22

WORKDIR /opt/server

# Patch OS (still important even with newer Alpine)
RUN apk update && apk upgrade --no-cache

RUN addgroup -S roboshop && adduser -S roboshop -G roboshop

COPY --from=build --chown=roboshop:roboshop /opt/server /opt/server

ENV MONGO="true" \
    MONGO_URL="mongodb://mongodb:27017/catalogue"

EXPOSE 8080

USER roboshop

CMD ["node", "server.js"]

# FROM node:20
# WORKDIR /opt/server
# COPY package.json .
# COPY *.js .
# RUN npm install
# ENV MONGO="true" \
#     MONGO_URL="mongodb://mongodb:27017/catalogue"
# CMD ["node", "server.js"]