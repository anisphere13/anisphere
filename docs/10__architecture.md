# 10- Architecture

| 📁 Structure principale (lib/)                                                                 |
|:-----------------------------------------------------------------------------------------------|
| lib/                                                                                           |
| ├── main.dart                          ⟶ Point d’entrée de l’app                               |
| ├── firebase_options.dart              ⟶ Config Firebase                                       |
| ├── services/                          ⟶ Services globaux (non liés à un module)               |
| │   ├── firebase_service.dart                                                                  |
| │   └── local_storage_service.dart                                                             |
| ├── providers/                         ⟶ Providers globaux                                     |
| │   └── user_provider.dart                                                                     |
| ├── modules/                           ⟶ Tous les modules indépendants                         |
| │   ├── noyau/                         ⟶ Noyau central de l’app                                |
| │   │   ├── models/                                                                            |
| │   │   ├── screens/                                                                           |
| │   │   ├── services/                                                                          |
| │   │   └── providers/                                                                         |
| │   ├── sante/                                                                                 |
| │   ├── pistage/                                                                               |
| │   ├── education/                                                                             |
| │   ├── communauté/                                                                            |
| │   └── [autres modules personnalisés]                                                         |
| nan                                                                                            |
| ✅ Règles d’organisation :                                                                     |
| - Chaque module possède ses propres dossiers models/, screens/, services/, providers/, tests/. |
| - Le noyau (noyau/) est lui aussi considéré comme un module.                                   |
| - Les fichiers globaux restent dans lib/services ou lib/ selon leur portée.                    |
| nan                                                                                            |
| 📦 Avantages :                                                                                 |
| - Compatible avec future conversion en mono-repo ou packages Flutter.                          |
| - Facilite désactivation ou export indépendant de chaque module.                               |
| - Favorise l’utilisation d’IA locale/contextuelle.                                             |
| - Organisation claire pour développeurs futurs.                                                |