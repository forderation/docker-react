# Build step just install depedency production
# and build app
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .

RUN npm install

# to enable log verbose
# RUN npm install --dd

COPY . .
RUN npm run build

# Running phase, just copy result of build without install dependecy
# to nginx dir
FROM nginx
# Copy from builder phase on dir /app/build to running phase
COPY --from=builder /app/build /usr/share/nginx/html
# Nginx is start automatically