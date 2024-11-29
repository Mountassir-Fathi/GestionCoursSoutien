# Gestion de Cours de Soutien Scolaire

Une application web développée en Java EE pour gérer efficacement les écoles de cours de soutien scolaire, en leur offrant des outils pour administrer les étudiants, les enseignants, les paiements, et bien plus encore.

## 📚 Objectif du Projet
Le projet vise à fournir une solution complète pour :
- Améliorer la gestion administrative des écoles de soutien scolaire.
- Offrir une interface intuitive pour les étudiants, les enseignants et les administrateurs.
- Garantir la sécurité et la fiabilité des données sensibles.

## 🛠️ Fonctionnalités Principales
### Administrateur
- Gestion des professeurs : Ajouter, modifier, supprimer, consulter.
- Gestion des étudiants : Inscrits et non inscrits.
- Gestion des matières, niveaux, groupes, salles et séances.
- Suivi des paiements et des absences.
- Tableau de bord pour visualiser les statistiques clés.

### Enseignant
- Consulter les horaires.
- Gestion des absences des étudiants.
- Accès à leur profil personnel.

### Étudiant
- Consulter les horaires.
- Suivi des paiements mensuels.
- Gestion de leur profil personnel.

## 🔒 Exigences Non Fonctionnelles
- **Sécurité** : Authentification robuste, chiffrement des données.
- **Disponibilité** : Sauvegardes automatiques, haute disponibilité.
- **Compatibilité** : Fonctionne sur différents appareils (Windows, macOS, Android, iOS).

## ⚙️ Technologies Utilisées
- **Langages** : Java (JEE), JSP, JSTL, HTML, CSS, JavaScript.
- **Serveur d'applications** : Apache Tomcat.
- **Base de données** : MySQL.
- **Modélisation UML** : Diagrammes de cas d'utilisation et de classes.

## 🚀 Installation et Déploiement
### Prérequis
- JDK (Java Development Kit).
- Apache Tomcat.
- MySQL (configuration de la base de données).

### Étapes
1. Clonez le dépôt :
   ```bash
   git clone https://github.com/Mountassir-Fathi/GestionCoursSoutien.git
   
2. **Configuration de la base de données**  
   - Utilisez le fichier `schema.sql` fourni pour créer les tables nécessaires dans votre base de données MySQL.
   - Configurez les paramètres de connexion (nom d'utilisateur, mot de passe, URL de la base de données) dans le fichier `persistence.xml` ou dans votre fichier de configuration JDBC selon votre projet.

3. **Importation du projet dans l'IDE**  
   - Ouvrez votre IDE (Eclipse ou IntelliJ IDEA).  
   - Importez le projet en sélectionnant le répertoire principal contenant les fichiers source et la configuration Maven (ou Gradle si applicable).  
   - Assurez-vous que toutes les dépendances nécessaires sont résolues.

4. **Déploiement sur Apache Tomcat**  
   - Exportez le projet sous forme de fichier WAR depuis votre IDE.  
   - Placez le fichier WAR dans le répertoire `webapps` de votre installation Apache Tomcat.  
   - Démarrez Tomcat et assurez-vous que le déploiement est terminé sans erreur.  

5. **Accéder à l'application**  
   - Ouvrez un navigateur web et accédez à l'application via l'URL suivante :  
     ```
     http://localhost:8080/EcoleSalam
     ```
   - Remplacez `EcoleSalam` par le nom attribué lors de la configuration.

## 🎨 Interfaces Clés  
- **Page d'accueil** : Présentation générale des fonctionnalités et options de navigation.  
- **Interface d'authentification** : Permet aux utilisateurs (administrateurs, enseignants, étudiants) de se connecter.  
- **Tableau de bord administratif** : Vue centralisée des statistiques, des utilisateurs et des paiements.  
- **Gestion des horaires, paiements et absences** : Outils interactifs pour consulter et administrer ces éléments.

## 👨‍💻 Auteurs  
Ce projet a été réalisé par **Fathi Mountassir** dans le cadre du module Java EE, sous l'encadrement bienveillant de **Pr. Abdessamad Belangour**.  
Un grand merci pour son soutien et ses conseils précieux tout au long de ce projet.



