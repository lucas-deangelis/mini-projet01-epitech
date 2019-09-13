FROM node:lts-alpine

# définit le dossier 'app' comme dossier de travail
WORKDIR /app/client

# copie 'package.json' et 'package-lock.json' (si disponible)
# COPY package*.json ./
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN cp -a /tmp/node_modules /app/client

# installe les dépendances du projet
RUN npm install --log-level=error

# copie les fichiers et dossiers du projet dans le dossier de travail (par exemple : le dossier 'app')
COPY . .

# construit l'app pour la production en la minifiant
RUN npm run build

EXPOSE 8080
CMD [ "dist" ]