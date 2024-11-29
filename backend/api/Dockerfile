FROM node:20

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

ENV NODE_ENV=development
ENV PORT=3000
ENV MONGO_URI=mongodb://root:example@mongodb:27017/exampledb?authSource=admin
ENV API_URL=http://localhost:3000
ENV SESSION_SECRET=secret

ENV MAILGUN_API_KEY=api-key
ENV MAILGUN_DOMAIN=domain
ENV MAILGUN_USERNAME=username

EXPOSE 3000
CMD ["node", "server.js"]
