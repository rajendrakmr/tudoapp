FROM node:20 as builder

WORKDIR /app/src

COPY . /app/src/

RUN npm install

EXPOSE 5173

CMD [ "npm","run","dev" ]
