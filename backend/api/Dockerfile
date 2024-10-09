FROM node:20

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

ENV ACCESS_TOKEN_SECRET=1234abcdABCD
ENV REFRESH_TOKEN_SECRET=ABCDabcd1234

EXPOSE 3000
CMD ["node", "server.js"]
