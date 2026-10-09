-- ZooTickoon - kit zootickoon-data - 03_controle.sql
-- Verification apres import. Valeurs attendues en commentaire. Date de reference : 2026-09-05.
USE zootickoon;

-- 1. Comptes de lignes
SELECT 'secteur' AS table_, COUNT(*) AS lignes FROM secteur      -- attendu 6
UNION ALL SELECT 'animal', COUNT(*) FROM animal                  -- attendu 32
UNION ALL SELECT 'agent', COUNT(*) FROM agent                    -- attendu 10
UNION ALL SELECT 'ticket', COUNT(*) FROM ticket;                 -- attendu 44

-- 2. Tickets par statut                                         -- attendu ouvert 6, en_cours 7, resolu 31
SELECT statut, COUNT(*) AS nb FROM ticket GROUP BY statut;

-- 3. Animaux en soins (non visibles)                            -- attendu 3
SELECT nom, espece, secteur FROM animal WHERE statut = 'soins';

-- 4. Naissances des douze derniers mois (flux RSS)              -- attendu 3
SELECT nom, espece, datenaissance FROM animal WHERE datenaissance >= DATE_SUB('2026-09-05', INTERVAL 12 MONTH) ORDER BY datenaissance DESC;

-- 5. Le moteur de chaque table                                     -- attendu InnoDB pour les 4 tables
SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'zootickoon' ORDER BY TABLE_NAME;

-- 6. Tickets non resolus hors delai (haute 24 h, moyenne 72 h, basse 168 h)  -- attendu 5
SELECT noticket, priorite, datecreation,
       TIMESTAMPDIFF(HOUR, datecreation, '2026-09-05 12:00:00') AS heures_ouvertes
  FROM ticket
 WHERE statut <> 'resolu'
   AND TIMESTAMPDIFF(HOUR, datecreation, '2026-09-05 12:00:00') > CASE priorite WHEN 'haute' THEN 24 WHEN 'moyenne' THEN 72 ELSE 168 END
 ORDER BY datecreation;
