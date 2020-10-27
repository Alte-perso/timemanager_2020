FROM node:latest

RUN mkdir front
COPY . /front
WORKDIR /front

RUN npm install

CMD ["npm", "run", "serve"]