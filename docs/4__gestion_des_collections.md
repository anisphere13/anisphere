🗃️ 4__gestion_des_collections.md — Structure des données AniSphère

Ce fichier définit les collections principales utilisées dans Firestore et leur structure. Il sert de référence pour le développement, le test et l’optimisation des requêtes. Il distingue les collections liées :

au noyau (utilisateur, animal)

aux modules (santé, éducation, etc.)

🔑 Règles générales

Les données sensibles (nom, prénom, téléphone) sont stockées uniquement en local (Hive).

L’email est la seule info obligatoire pour l’enregistrement.

Chaque collection est conçue pour minimiser les lectures et écritures Firestore.

Les données sont liées par des UID (utilisateur, animal) générés localement et synchronisés au cloud.

👤 Collection users

🔹 Objectif

Stocker les informations non sensibles des utilisateurs + rôles actifs.

🔹 Structure

users (collection) └── [userId] (document) ├── email: string ├── dateCreated: timestamp ├── roles: [string] (ex: ["pro", "asso"]) ├── modulesActifs: [string] └── metadata: object (app version, OS...) 

🐶 Collection animals

🔹 Objectif

Stocker les données générales des animaux liés à un utilisateur.

🔹 Structure

animals (collection) └── [animalId] (document) ├── ownerId: string (ref vers userId) ├── nom: string ├── espece: string ├── race: string ├── genre: string (M/F) ├── dateNaissance: date ├── puce: string (optionnelle) ├── dateAjout: timestamp └── statut: string (actif/perdu/décédé) 

❤️ Collection sante

🔹 Objectif

Centraliser les données médicales de chaque animal (synchronisation possible après OCR).

🔹 Structure

sante (collection) └── [animalId] (document) ├── vaccinations: [ { nom, date, rappel, veterinaire } ] ├── traitements: [ { nom, dateDebut, duree, posologie } ] ├── poids: [ { date, valeur } ] ├── alertes: [string] └── remarques: string 

🎓 Collection education

🔹 Objectif

Suivre les progrès éducatifs d’un animal, manuellement ou via IA.

🔹 Structure

education (collection) └── [animalId] (document) ├── exercices: [ { nom, type, statut, dateDernierTest } ] ├── socialisation: [ { type, lieu/bruit, validé } ] └── playlist: [ { son, validé, niveau } ] 

🐕 Collection dressage

🔹 Objectif

Gérer le suivi des entraînements spécifiques (pistage, concours...)

🔹 Structure

dressage (collection) └── [animalId] (document) ├── pistage: [ { date, parcours, note } ] ├── detection: [ { objet, réussite, durée } ] ├── agility: [ { date, score, temps } ] └── remarques: string 

🧑‍🤝‍🧑 Collection communaute

🔹 Objectif

Centraliser les interactions communautaires et les échanges.

🔹 Structure

communaute (collection) └── [userId] (document) ├── spheres: number ├── echanges: [ { type, avec, date, validé } ] ├── reputation: number └── historique: [string]

🆘 Collection support

🔹 Objectif

Centraliser les retours utilisateurs : bug, idée, contact et feedback IA.

🔹 Structure

support (collection)
 └── [feedbackId] (document)
     ├── userId: string
     ├── type: string (bug, idee, contact)
     ├── message: string
     ├── status: string (brouillon, lu, traité)
     ├── createdAt: timestamp
     └── updatedAt: timestamp

📨 Collection messages

🔹 Objectif

Gérer les conversations privées entre utilisateurs.

🔹 Structure

messages (collection)
 └── [conversationId] (document)
     ├── participants: [string]
     ├── lastMessage: string
     ├── updatedAt: timestamp
     └── messages (subcollection)
         └── [messageId] (document)
             ├── senderId: string
             ├── text: string
             ├── sentAt: timestamp
             └── readBy: [string]

💳 Collection subscriptions

🔹 Objectif

Gérer les abonnements premium ou pro des utilisateurs.

🔹 Structure

subscriptions (collection)
 └── [subscriptionId] (document)
     ├── userId: string
     ├── type: string
     ├── startDate: timestamp
     ├── expiryDate: timestamp
     ├── status: string (active, expired, cancelled)
     └── lastSync: timestamp (optionnelle)


🗂️ Compléments prévus

notifications (par module + type)

partages (utilisateurs/animaux liés entre comptes)

medias (images, vidéos, tri automatique IA)

historique (actions IA ou utilisateur)

📊 Collection logs_ia

🔹 Objectif

Centraliser tous les logs IA envoyés par l'application pour analyse ou apprentissage.

🔹 Structure

logs_ia (collection)
 └── [logId] (document)
     ├── module: string
     ├── type: string
     ├── userId: string
     ├── animalId: string
     ├── data: map (optionnelle)
     ├── metadata: map (optionnelle)
     └── timestamp: timestamp

Exemple de document :

```json
{
  "module": "education",
  "type": "exercise_completed",
  "userId": "u123",
  "animalId": "a456",
  "data": {"exerciseId": "sit", "score": 95},
  "metadata": {"appVersion": "1.2.0"},
  "timestamp": "2025-06-12T16:45:00Z"
}
```

📌 Recommandations Firebase

Minimiser les lectures avec whereEqualTo, limit, startAfter...

Préférer les sous-collections que les tableaux imbriqués si la liste est longue

Regrouper les mises à jour (batch write)

Éviter les listeners en temps réel sauf besoin critique

Supprimer les documents obsolètes (ex : animaux supprimés)

