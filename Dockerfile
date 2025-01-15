# Stage 1: Builder
FROM node:20 as builder

WORKDIR /app

# Copy only package.json and package-lock.json to optimize caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Production
FROM node:20-alpine as production

WORKDIR /app

# Copy only the build output and necessary files from the builder stage
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./

# Install production dependencies only
RUN npm install --only=production

# Expose the application port
EXPOSE 5173

# Set the default command to run the app
CMD ["npm", "run", "serve"]


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
