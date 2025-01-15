# Stage 1: Builder
FROM node:20 as builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json to optimize caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the application (creates a production-ready build in /app/dist)
RUN npm run build

# Stage 2: Production
FROM nginx:stable-alpine as production

# Set working directory to nginx's default static directory
WORKDIR /usr/share/nginx/html

# Copy build output from builder stage
COPY --from=builder /app/dist ./

# Copy custom nginx configuration if needed (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for serving static files
EXPOSE 80

# Start nginx (default CMD for nginx image)
CMD ["nginx", "-g", "daemon off;"]



# FROM node:20 as builder

# WORKDIR /app/src

# COPY . /app/src/

# RUN npm install

# EXPOSE 5173

# CMD [ "npm","run","dev" ]



# FROM node:20 as builder

# WORKDIR /app/src

# COPY . /app/src/

# RUN npm install

# FROM nginx:alpine AS runtime

# COPY --from=builder /app/dist /usr/share/nginx/html

# EXPOSE 80 

# CMD ["nginx", "-g", "daemon off;"]
