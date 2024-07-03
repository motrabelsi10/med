# Utilisez une image Nginx de base à partir du Docker Hub
FROM nginx:alpine

# Copiez les fichiers HTML de votre site dans le répertoire de contenu de Nginx
COPY index.html /usr/share/nginx/html

# Exposez le port 80 pour le trafic web
EXPOSE 80