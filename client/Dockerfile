FROM node:10

RUN apt-get update

RUN npm install -g http-server

# définit le dossier 'app/client' comme dossier de travail
WORKDIR /opt/app

# copie 'package.json' et 'package-lock.json' (si disponible)
#COPY package*.json ./
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN cp -a /tmp/node_modules /app/client

# installe les dépendances du projet
RUN npm install --log-level=error

# copie les fichiers et dossiers du projet dans le dossier de travail (par exemple : le dossier 'app')
COPY . .

RUN npm run build

# CMD npm run serve&

EXPOSE 8080

CMD ["http-server", "dist"]