# Fiche d'incident - gabarit (mission 2, les cinq pannes)

Une fiche par panne. Elle se remplit pendant le diagnostic, pas après : la colonne « ce que j'ai vérifié » est la preuve de la méthode.

| Champ | Contenu |
|---|---|
| Numéro | panne 1 à 5 |
| Symptôme observé | ce que voit l'utilisateur, mot pour mot (message du navigateur, code HTTP, délai) |
| Où ça casse | poste client, réseau, serveur, application ? entourer un seul niveau à la fin |
| Ce que j'ai vérifié, dans l'ordre | 1. … (commande ou geste, résultat) 2. … 3. … |
| Cause | une phrase |
| Correction | le geste qui a rétabli le service |
| Comment éviter que ça revienne | une phrase ; « rien » est une réponse acceptable si elle est argumentée |
| Durée du diagnostic | minutes |

Méthode attendue : du plus proche au plus loin. Le poste client d'abord (le nom se résout-il ? vers quelle adresse ?), le réseau ensuite (la machine répond-elle ? le port est-il ouvert ?), le serveur (Apache tourne-t-il ? que disent ses journaux ?), l'application en dernier (404, erreur PHP).
