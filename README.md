# GitOps: CI/CD using GitHub Actions, Helm and ArgoCD on Kubernetes

Ce projet utilise les outils modernes de déploiement et d'automatisation suivants : Helm, Argo CD et GitHub Actions.
Helm est un gestionnaire de packages pour Kubernetes, facilitant le déploiement et la gestion d'applications dans des clusters Kubernetes via des charts configurables. 
Argo CD est un outil de livraison continue pour Kubernetes, permettant de déployer et de synchroniser automatiquement les applications dans un environnement Kubernetes à partir d'un dépôt Git.
GitHub Actions est utilisé pour automatiser les workflows de build, test et déploiement directement à partir de GitHub.

# GitOps
GitOps est une méthodologie de gestion de l'infrastructure et des applications utilisant Git comme source unique de vérité. Elle implique l'utilisation de Git pour stocker et contrôler la version de tous les fichiers de configuration et le code de l'infrastructure et des applications, puis l'utilisation de l'automatisation pour garantir que l'état du système correspond toujours à l'état désiré défini dans Git. Cette approche permet des déploiements plus rapides et plus fiables, ainsi qu'une collaboration et un contrôle de version plus faciles.

# CI/CD with GitOps, Github Actions, Helm and ArgoCD
![Texte Alternatif](images/cicd-pipeline.png)

# Prérequis
## Helm
1. **Installer Helm**

   Pour installer Helm, suivez ces étapes :

   ```bash
   curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
   sudo apt-get install apt-transport-https --yes
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
   sudo apt-get update
   sudo apt-get install helm

2. **Créer un Chart**

   Pour créer un nouveau chart avec Helm, exécutez la commande suivante :
   ```bash
   helm create my-chart

3. **Libérer une Version**

   Pour libérer une nouvelle version à partir de votre chart, utilisez la commande suivante :
   ```bash
   helm install my-release ./my-chart -n mynamespace

4. **Explication**

   Une release est une instance installée d'un chart
   helm install my-web-app ./test --namespace testnamespace
   
   - `helm install` : La commande pour installer un chart Helm.
   - `my-release` : Le nom de la release.
   - `./mychart` : Le chemin vers le chart Helm (dans ce cas, le chart `test` que nous avons créé).
   - `-namespace mynamespace` : Le namespace Kubernetes où la release sera installée.

5. **Avantages de Helm**

   Helm permet de déployer des applications Kubernetes complexes en une seule commande
   
   **Configuration centralisée :** Les configurations des applications peuvent être centralisées dans des fichiers `values.yaml` 
   
   Avant Helm, le déploiement d'applications sur Kubernetes nécessitait de gérer manuellement les fichiers de configuration YAML pour chaque ressource Kubernetes (Deployments, Services, ConfigMaps, Secrets, etc.).

6. **Files**

   ***A. Structure du Chart Helm***

            my-chart/

            ├── Chart.yaml

            ├── values.yaml

            ├── charts/

            ├── templates/

            │   ├── deployment.yaml

            │   ├── service.yaml

            │   ├── _helpers.tpl

            │   └── ...

            └── ...


   ***B. Values.yaml***

      Il est utilisé pour définir et personnaliser les valeurs des variables utilisées dans les templates Kubernetes du chart.
      Le fichier values.yaml contient les valeurs par défaut pour les variables de configuration de votre chart Helm. Ce fichier est utilisé pour définir les configurations que vous pouvez personnaliser lorsque vous déployez votre application. Voici un exemple de ce         que vous pourriez trouver dans values.yaml :

      ![Texte Alternatif](images/image.png)
   
   ***C. Deployment.yaml***

      Le fichier deployment.yaml est un template Kubernetes pour le déploiement de vos applications. Ce fichier utilise les valeurs définies dans values.yaml pour créer les ressources Kubernetes nécessaires. Voici un exemple de deployment.yaml :

      ![Texte Alternatif](images/image1.png)

# ArgoCD 

   1. **Definition**
   
   ArgoCD is a popular open-source GitOps tool for managing Kubernetes applications. It uses a pull-based model to continuously monitor the Git repository for changes and automatically deploy them to the target environment.
   
   Argocd has a controller inside the cluster 
   
   argocd is a pull model

   - Continious Delivery Tool
   - Déploiements GitOps
   - Interface utilisateur et CLI
   - Gestion de plusieurs clusters
   - Synchronisation automatisée et manuelle
   - faciliter le déploiement et la gestion continus d'applications dans des environnements Kubernetes en utilisant des pratiques GitOps.

      
   2. **Installation**
   
   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   ```
   
   3. **Download Argo CD CLI**

   ```bash
   brew install argocd
   ```
   
   4. **Access The Argo CD API Server**
   
   ```bash
   kubectl port-forward svc/argocd-server -n argocd 8080:443
   ```

   5. **Login Using The CLI**
    
   ```bash
   argocd admin initial-password -n argocd   
   ```

   Using the username admin and the password from above, login to Argo CD's IP or hostname:

   ```bash
   argocd login <ARGOCD_SERVER>
   ```

   Change the password using the command:

   ```bash
   argocd account update-password
   ```

   3. **Create An Application From A Git Repository**

      ***A. Using Terraform***   
      
      ![Texte Alternatif](images/image3.png)

      
      ***Prérequis***

         Terraform doit être installé et configuré.
         Accès à un cluster Kubernetes avec Argo CD installé.
         Accès à un dépôt Git contenant les fichiers nécessaires pour votre application.

         ***Metadata***
         ****name****: Nom de l'application Argo CD.
         ****namespace****: Namespace où Argo CD est installé.
         ****labels****: Labels optionnels pour l'application.

         ***Spec***
         ****project****: Projet Argo CD sous lequel l'application sera gérée.
         
         ***Destination***
         
         ****server****: URL du serveur API Kubernetes.
         ****namespace****: Namespace cible dans le cluster Kubernetes.

         ***Source***         
         ****repo_url****: URL du dépôt Git contenant le chart Helm.
         ****path****: Chemin dans le dépôt où se trouve le chart Helm.
         ****target_revision****: Branche, tag ou commit Git à utiliser.

         ***Helm***
         ****release_name****: Nom de la release Helm.
         ****value_files****: Liste optionnelle de fichiers de valeu````rs Helm.

         ***Sync Policy***         
         ****prune****: Supprime automatiquement les ressources non définies dans la source.
         ****self_heal****: Synchronise automatiquement l'application si elle diverge de l'état souhaité.

      ***Initialiser et Appliquer la Configuration Terraform***

         ```bash
         terraform init
         terraform plan
         terraform apply
         ```

      ***B. Creating Apps Via UI***
      
      After logging in, click the + New App button as shown below:
      Give your app the name my-app , use the project default, and leave the sync policy as Manual

      Connect the <repo_URL> repo to Argo CD by setting repository url to the github repo url, leave revision as HEAD, and set the path to <Helm_Directory>
      
      For Destination, set cluster URL to https://kubernetes.default.svc (or in-cluster for cluster name) and namespace to default

      After filling out the information above, click Create at the top of the UI to create the my-app application

   4. **Sync (Deploy) The Application**

      The application status is initially in OutOfSync state since the application has yet to be deployed, and no Kubernetes resources have been created. To sync (deploy) the application, run:
      
         ```bash
         argocd app get my-app
         argocd app sync my-app
         ```