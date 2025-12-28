# 🌤️ WeatherApp – Application Météo Flutter

## 📱 Description du projet

**WeatherApp** est une application mobile multiplateforme développée avec **Flutter** permettant de consulter la météo en temps réel.  
L’application fournit des informations météorologiques précises basées sur la **géolocalisation** de l’utilisateur ou la **recherche manuelle d’une ville**.

Le projet exploite une **architecture propre (MVC / Clean Architecture)** et intègre des services cloud pour l’authentification et la gestion des utilisateurs.

---

## 🎯 Objectifs

- Développer une application mobile **Android & iOS** avec une seule base de code
- Consommer une **API REST météo** en temps réel
- Gérer l’**authentification utilisateur** de manière sécurisée
- Mettre en place une **architecture maintenable et scalable**
- Offrir une **interface utilisateur fluide et intuitive**

---

## 🚀 Fonctionnalités

- 🔐 Authentification utilisateur (Firebase Authentication)
- 📍 Détection automatique de la position (GPS)
- 🔎 Recherche météo par nom de ville
- 🌡️ Affichage de la température, humidité, vent et conditions météo
- 🎨 Interface moderne avec arrière-plans dynamiques (jour / nuit)
- ⚡ Gestion d’état réactive avec GetX
- ❗ Gestion des erreurs (ville introuvable, problème réseau, permissions)

---

## 🛠️ Technologies utilisées

- **Flutter** & **Dart**
- **Firebase Authentication**
- **OpenWeatherMap API**
- **GetX** (gestion d’état & navigation)
- **Dio** (requêtes HTTP)
- **Geolocator** (géolocalisation)
- **Lottie** (animations)

---

## 🧱 Architecture du projet

Le projet suit une architecture **MVC étendue / Clean Architecture** :

- **Model** : gestion des données et parsing JSON
- **View** : interface utilisateur (UI)
- **Controller** : logique métier et gestion d’état

---

## 📂 Structure du projet

```text
lib/
│── controller/
│   ├── auth_controller.dart
│   ├── weather_controller.dart
│   └── location_controller.dart
│
│── model/
│   ├── weather_model.dart
│   └── weather_model.g.dart
│
│── service/
│   └── api_service.dart
│
│── view/
│   ├── auth/
│   ├── home/
│   ├── splash/
│   └── core/
│
└── main.dart
````

---

## 🔑 Configuration API & Firebase

### 1️⃣ OpenWeatherMap

* Créer un compte sur [https://openweathermap.org](https://openweathermap.org)
* Générer une **clé API**
* Ajouter la clé dans le fichier de configuration (ex : `api_service.dart`)

### 2️⃣ Firebase

* Créer un projet Firebase
* Activer **Firebase Authentication (Email / Password)**
* Ajouter les fichiers :

  * `google-services.json` (Android)
  * `GoogleService-Info.plist` (iOS)

---

## ▶️ Installation et exécution

```bash
# Cloner le projet
git clone https://github.com/votre-username/weatherapp-flutter.git

# Accéder au dossier
cd weatherapp-flutter

# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run
```

---

## 📸 Captures d’écran

> [Les captures d’écran de l’application](https://github.com/IMANE020/ACE/tree/main/Projet/backend)

---

## 📈 Perspectives d’évolution

* 🔔 Notifications push (alertes météo)
* 🗺️ Carte météo interactive (Google Maps)
* 🌐 Internationalisation (FR / EN / AR)
* 💾 Mode hors-ligne avec cache local
* ⭐ Favoris et historique des villes

---

## 👨‍💻 Réalisé par

* **Asmae Mossaddak**
* **Imane Tayb**
* **Assia El Attary**

🎓 *École Marocaine des Sciences de l’Ingénieur (EMSI)*
📅 *Année universitaire : 2024 – 2025*

---

## 📚 Références

* Flutter Documentation : [https://flutter.dev](https://flutter.dev)
* Firebase Documentation : [https://firebase.google.com](https://firebase.google.com)
* OpenWeatherMap API : [https://openweathermap.org/api](https://openweathermap.org/api)
* GetX Package : [https://pub.dev/packages/get](https://pub.dev/packages/get)

---
