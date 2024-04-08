FROM node:latest

WORKDIR /app/backend

COPY package*.json ./

RUN curl -v https://registry.npmjs.com/
RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]