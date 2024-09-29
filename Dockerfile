# Step 1: Use an official Node.js image as a base
FROM node:14

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Step 4: Install the application dependencies
RUN npm install --production

# Step 5: Copy the rest of the application code to the working directory
COPY . .

# Step 6: Expose the port that your application runs on
EXPOSE 3000

# Step 7: Define the command to run your application
CMD ["npm", "start"]

