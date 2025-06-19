🎨 5__ux.md — UX & Navigation d’AniSphère

Ce fichier rassemble tous les principes d’ergonomie, de navigation et d’expérience utilisateur d’AniSphère. Il sert de base pour le design des écrans, des parcours utilisateurs et des modules.

🧭 Vision générale UX

L’expérience utilisateur est inspirée de Samsung Health : lisible, fluide, centrée sur l’animal.

L’utilisateur peut avoir plusieurs profils de rôles : particulier, vétérinaire, éleveur, éducateur, etc.

L’application est pensée pour gérer plusieurs animaux avec une navigation simple, rapide et logique.

Les modules sont activables/désactivables à volonté.

La personnalisation UX dépend du rôle de l’utilisateur et des modules actifs.

🖼️ Structure de l’interface

Barre de navigation principale (bas)

4 onglets fixes :

Accueil : tableau de bord global, infos de l’animal sélectionné, raccourcis.

Partage : données partagées avec d’autres utilisateurs, liens d’accès.

Magasin de modules : ajout/suppression de modules actifs.

Mes animaux : liste des animaux, profils complets, accès modules spécifiques.

Éléments fixes (haut)

Icône notifications (haut droite)

Icône paramètres / mon compte (roue crantée)

Slide Up (écran d’accueil)

Bouton d’action flottant ouvrant un panneau d’actions rapides :
ajouter un animal, note santé, photo ou activité.

📇 Carte d’identité et widgets modulaires

Carte d’identité de l’animal sélectionné affichée en haut de l’accueil, avec changement rapide d’animal.

Liste verticale de widgets pour chaque module actif, couleurs propres à chaque module.

Réagencement ou masquage des widgets via un menu dédié.

Un tap sur un widget ouvre l’accueil du module correspondant.

☀️ / 🌙 Thèmes et personnalisation

Mode clair / sombre natif, sélection automatique ou forcée.

Personnalisation possible de l’interface : couleurs secondaires, photo de l’animal en fond, etc.

🔁 Parcours utilisateur (Onboarding)

Connexion simple : email seul → OAuth facultatif ensuite.

Tutoriel intelligent dès le premier lancement : 

Présentation rapide de l’interface.

OCR carnet de santé pour import automatique.

Ajout guidé du premier animal.

L’utilisateur peut accéder à l’app sans compte pour explorer (lecture seule), inscription demandée à l’ajout.

🧠 Intelligence UX intégrée

Notifications IA personnalisées : urgentes, utiles, ou suggérées.

Navigation dynamique selon modules activés.

Tutoriels adaptés au rôle (pro, particulier...).

Suggestions IA contextuelles : heure, météo, habitude, module utilisé récemment.

ia_suggestion_card widgets apparaissant sur l’accueil ou dans un module, contenant un conseil IA personnalisé.

Possibilité de les rejeter par swipe, ce qui alimente l’IA.

ia_chip courts rappels intégrés dans les listes, tap pour voir l’explication IA.

Translucidité IA : chaque recommandation peut être cliquée pour afficher le raisonnement de l'IA (transparence et pédagogie).

📊 Écrans interactifs et ergonomie visuelle

Graphiques dynamiques (santé, éducation, activité...)

Cartes visuelles pour le pistage, la communauté, les expositions.

Retour haptique léger + animation fluide pour toute action significative.

Accès rapide à tout moment à la fiche de l’animal sélectionné.

Depuis cette fiche, un bouton **Généalogie** ouvre l’arbre familial complet.
Un lien **Profil public** permet de partager la lignée en lecture seule.

Glisser-déposer intelligent dans les listes (objectifs, rappels, tâches).

Barre de recherche universelle (animaux, modules, historique, contenus).

🧩 Personnalisation profonde de l’interface

Navigation à onglets dynamiques selon modules activés.

"Vue Focus" sur un animal : affiche en plein écran tous les éléments rattachés (santé, stats, éducation...).

Mode senior / enfant : taille des boutons, interface épurée.

Mode professionnel : affichage condensé, filtres rapides, vue fiche médicale prioritaire.

🏅 Gamification et engagement utilisateur

Système de récompenses par jalons : chaque étape majeure débloque un badge conservé dans une galerie de trophées.
Lors du déblocage, une pluie de confettis et une vibration courte marquent l’événement.
Ces animations demeurent brèves et peuvent être désactivées depuis les paramètres.
Journée de l’animal : moment hebdomadaire avec rappels affectifs, statistiques, photos souvenirs.
Widget quotidien / notification inspirante : « Aujourd’hui est parfait pour une sortie éducative avec Max ! »
Rétroaction IA : « Bravo, vous avez complété tous les rappels cette semaine. Pensez à synchroniser un nouveau vaccin. »

🔁 Checklist & accroche quotidienne

Checklist du jour par animal : soins, rappels, interactions.

Historique de progression, graphique et suggestions IA.

Fil d’actualité privé : résumé des mises à jour d’un animal partagé.

Statistiques motivantes : "Vous avez interagi avec Luna 12 fois cette semaine."

💡 Design évolutif

Les modules ajoutés injectent dynamiquement leurs éléments dans l’interface.

Le magasin de modules devient l’élément pivot de la personnalisation UX.

L’IA peut proposer de nouveaux modules à activer selon usage.

📌 Règles de design à respecter

Icônes toujours accompagnées de labels.

Navigation à 2 niveaux max par onglet.

Retour accessible à tout moment.

Aucune action destructrice sans confirmation.

Respect du Material Design Flutter.


