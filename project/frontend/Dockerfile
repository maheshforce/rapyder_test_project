# Step 1: Build the React app using Node.js
FROM node:16 AS build

WORKDIR /app

# Copy package.json and package-lock.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the app's source code
COPY . .

# Build the app for production
RUN npm run build

# Step 2: Serve the build with Nginx
FROM nginx:alpine

# Copy the build files from the Node.js container to Nginx's default directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for HTTP traffic
EXPOSE 80

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
