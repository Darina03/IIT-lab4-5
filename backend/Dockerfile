FROM node:latest

WORKDIR /app/backend

COPY package*.json ./

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
RUN nvm install node

COPY . .

EXPOSE 3000

CMD ["nvm", "start"]