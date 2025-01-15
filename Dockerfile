# FROM node:20 as builder

WORKDIR /app/src

COPY . /app/src/

RUN npm install

EXPOSE 5173

CMD [ "npm","run","dev" ]



# FROM node:20 as builder

# WORKDIR /app/src

# COPY . /app/src/

# RUN npm install

# FROM nginx:alpine AS runtime

# COPY --from=builder /app/dist /usr/share/nginx/html

# EXPOSE 80 

# CMD ["nginx", "-g", "daemon off;"]
