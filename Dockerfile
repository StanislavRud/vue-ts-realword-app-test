FROM node:12

WORKDIR /app

COPY package*.json /app

RUN yarn install

COPY . .

EXPOSE 8080

CMD yarn serve