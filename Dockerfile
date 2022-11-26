# First the build phase
FROM node:14-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# We now should have the stuff we need in the /app/build directory

# Now the run phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

#default start command in nginx container is to start server so we're done