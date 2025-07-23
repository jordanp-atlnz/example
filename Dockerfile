FROM node:14-alpine
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
COPY --chown=node:node . .
RUN npm ci
EXPOSE 8080
USER node
CMD ["npm", "start"]
