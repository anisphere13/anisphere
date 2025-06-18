📡 firebase_function_examples.md — Exemples d'appel aux fonctions cloud

Ce document explique comment appeler les Cloud Functions d'AniSphère depuis Flutter ou n'importe quelle requête HTTP.

## storeSensitiveUserData

Cette fonction enregistre des informations sensibles sur l'utilisateur dans la collection `cloud_users`.

### Avec Flutter

```dart
final storeSensitiveUserData = FirebaseFunctions.instance
    .httpsCallable('storeSensitiveUserData');
final result = await storeSensitiveUserData.call({
  'nom': 'Dupont',
  'prenom': 'Alice',
  'email': 'alice@example.com',
  'telephone': '+33123456789',
  'adresse': '1 rue de la Paix',
  'consentementIA': true,
  'premium': false,
});
print(result.data); // { status: "success", message: "Données utilisateur stockées." }
```

### Via une requête REST

La même fonction peut être appelée avec `fetch` ou `curl`. Remplacez `<region>` par la région de déploiement et `<projectId>` par l'identifiant Firebase.

```bash
curl -X POST \
  -H "Authorization: Bearer <ID_TOKEN>" \
  -H "Content-Type: application/json" \
  https://<region>-<projectId>.cloudfunctions.net/storeSensitiveUserData \
  -d '{
    "data": {
      "nom": "Dupont",
      "prenom": "Alice",
      "email": "alice@example.com",
      "telephone": "+33123456789",
      "adresse": "1 rue de la Paix",
      "consentementIA": true,
      "premium": false
    }
  }'
```

L'`ID_TOKEN` provient d'un utilisateur authentifié. En développement local, lancez `firebase login` puis `firebase functions:shell` pour tester rapidement.

