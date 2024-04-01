FROM node:latest

WORKDIR /app/backend

COPY package*.json ./
RUN nvm install latest

COPY . .

EXPOSE 3000

CMD ["npm", "start"]