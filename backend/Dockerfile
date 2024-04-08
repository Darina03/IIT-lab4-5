FROM node:latest

WORKDIR /app/backend

COPY package*.json ./

RUN sudo npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]