# Étape de construction
FROM node:14-alpine as build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Étape de production
FROM node:14-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --only=production

COPY --from=build /usr/src/app/dist ./dist

EXPOSE 3000

CMD ["node", "dist/server.js"]
