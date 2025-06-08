# Step 1: Use the official Node.js image
FROM node:16

# Create and set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy the rest of the application code
COPY . ./

# Expose port 5000 for the backend API
EXPOSE 5000

# Start the server
CMD ["node", "server.js"]
