FROM node:20-alpine

WORKDIR /app

# Demo only - hardcoded secret (DO NOT USE IN PRODUCTION)
ENV APP_USERNAME=admin
ENV APP_PASSWORD=Password@123

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
