# ZooTickoon - kit de données

Le Parc animalier de Val-Sorin, tel que le projet le fournit dès la première mission. **Aucune donnée réelle** :
le parc, ses agents et ses adresses sont inventés ; les espèces sont réelles, les individus non.

| Dossier | Fichiers | Sert à |
|---|---|---|
| `csv/` | `secteurs.csv`, `animaux.csv`, `tickets.csv` (séparateur `;`) | lire les données dans un tableur, mission 1 |
| `json/` | `secteurs.json`, `animaux.json`, `tickets.json`, `agents.json` (mots de passe hachés) | mission 3 (formats, puis catalogue généré par PHP) et mission 4 (connexion des agents, tickets en fichier) |
| `xml/` | `animaux.xml` + `animaux.dtd` | mission 3 : bien formé, valide, comparaison avec le JSON |
| `sql/` | `01_schema.sql`, `02_seed.sql`, `03_controle.sql` | mission 4, étape 4 : la base ; contrôle après import |
| `images/` | six visuels de secteur et `animal.svg`, en SVG | à remplacer par des photos libres si vous en trouvez |
| `gabarits/` | fiche d'incident | mission 2 |

## Chiffres du jeu (date de référence 05/09/2026)

| | |
|---|---|
| secteurs | 6 |
| animaux | 32, dont 3 en soins (non visibles) et 3 nés depuis douze mois |
| agents | 10 : 1 administrateur, 2 techniciens, 7 agents |
| tickets | 44 : 6 ouverts, 7 en cours, 31 résolus ; 5 non résolus hors délai |

Délais cibles par priorité (mission 7, étape 1) : haute 24 h, moyenne 72 h, basse 168 h.

## Comptes de test

| Compte | Rôle | Mot de passe |
|---|---|---|
| `direction@zoo-valsorin.test` | administrateur | `Admin2026!` |
| `k.lefevre@zoo-valsorin.test`, `m.dasilva@zoo-valsorin.test` | technicien | `Zoo2026!` |
| les sept autres `@zoo-valsorin.test` | agent | `Zoo2026!` |

## Import de la base (mission 4, étape 4)

```bash
mysql -u root -p < sql/01_schema.sql
mysql -u root -p zootickoon < sql/02_seed.sql
mysql -u root -p zootickoon < sql/03_controle.sql
```

Les valeurs attendues sont en commentaire dans `03_controle.sql`, qui vérifie aussi que les quatre tables sont en **InnoDB**
(le moteur par défaut ; l'ancien MyISAM ignore les clés étrangères). Un chiffre qui diffère : relire le message d'import.
