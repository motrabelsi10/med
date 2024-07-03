# GitOps: CI/CD using GitHub Actions, Helm and ArgoCD on Kubernetes

Ce projet utilise les outils modernes de déploiement et d'automatisation suivants : Helm, Argo CD et GitHub Actions.
Helm est un gestionnaire de packages pour Kubernetes, facilitant le déploiement et la gestion d'applications dans des clusters Kubernetes via des charts configurables. 
Argo CD est un outil de livraison continue pour Kubernetes, permettant de déployer et de synchroniser automatiquement les applications dans un environnement Kubernetes à partir d'un dépôt Git.
GitHub Actions est utilisé pour automatiser les workflows de build, test et déploiement directement à partir de GitHub.

## GitOps
GitOps est une méthodologie de gestion de l'infrastructure et des applications utilisant Git comme source unique de vérité. Elle implique l'utilisation de Git pour stocker et contrôler la version de tous les fichiers de configuration et le code de l'infrastructure et des applications, puis l'utilisation de l'automatisation pour garantir que l'état du système correspond toujours à l'état désiré défini dans Git. Cette approche permet des déploiements plus rapides et plus fiables, ainsi qu'une collaboration et un contrôle de version plus faciles.

## CI/CD with GitOps, Github Actions, Helm and ArgoCD
![Texte Alternatif](images/cicd-pipeline.png)

## Prérequis

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
   A.***Values.yaml***
      Il est utilisé pour définir et personnaliser les valeurs des variables utilisées dans les templates Kubernetes du chart.
      Le fichier values.yaml contient les valeurs par défaut pour les variables de configuration de votre chart Helm. Ce fichier est utilisé pour définir les configurations que vous pouvez personnaliser lorsque vous déployez votre application. Voici un exemple de ce         que vous pourriez trouver dans values.yaml :
      ![Texte Alternatif](images/image.png)
   
   B.***Deployment.yaml***
      Le fichier deployment.yaml est un template Kubernetes pour le déploiement de vos applications. Ce fichier utilise les valeurs définies dans values.yaml pour créer les ressources Kubernetes nécessaires. Voici un exemple de deployment.yaml :
      ![Texte Alternatif](images/image1.png)

      
