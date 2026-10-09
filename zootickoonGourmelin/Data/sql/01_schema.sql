-- ZooTickoon - kit zootickoon-data - 01_schema.sql
-- Les quatre tables du zoo. Import : mysql -u root -p < 01_schema.sql  (le script cree la base)
-- ENGINE=InnoDB est ecrit en clair sur chaque table : c'est le moteur par defaut de MySQL et MariaDB, le seul qui
-- fait respecter les cles etrangeres et connait les transactions. L'ancien MyISAM les ignore en silence.

CREATE DATABASE IF NOT EXISTS zootickoon CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE zootickoon;

CREATE TABLE secteur (
  code              CHAR(3)       NOT NULL,
  nom               VARCHAR(40)   NOT NULL,
  description       TEXT          NOT NULL,
  surface_m2        INT           NOT NULL,
  capacite_animaux  INT           NOT NULL,
  image             VARCHAR(255)  DEFAULT NULL,
  PRIMARY KEY (code)
) ENGINE=InnoDB;

CREATE TABLE animal (
  noanimal       INT           NOT NULL AUTO_INCREMENT,
  espece         VARCHAR(60)   NOT NULL,
  nom            VARCHAR(60)   NOT NULL,
  secteur        CHAR(3)       NOT NULL,
  datenaissance  DATE          NOT NULL,
  regime         VARCHAR(20)   NOT NULL,
  statut         ENUM('visible', 'soins') NOT NULL DEFAULT 'visible',
  description    TEXT          NOT NULL,
  image          VARCHAR(255)  DEFAULT NULL,
  PRIMARY KEY (noanimal),
  KEY fk_animal_secteur (secteur),
  CONSTRAINT fk_animal_secteur FOREIGN KEY (secteur) REFERENCES secteur (code)
) ENGINE=InnoDB;

CREATE TABLE agent (
  mel         VARCHAR(60)   NOT NULL,
  motdepasse  VARCHAR(100)  NOT NULL,
  nom         VARCHAR(40)   NOT NULL,
  prenom      VARCHAR(40)   NOT NULL,
  role        ENUM('agent', 'technicien', 'administrateur') NOT NULL DEFAULT 'agent',
  PRIMARY KEY (mel)
) ENGINE=InnoDB;

CREATE TABLE ticket (
  noticket        INT           NOT NULL AUTO_INCREMENT,
  datecreation    DATETIME      NOT NULL,
  secteur         CHAR(3)       NOT NULL,
  sujet           VARCHAR(120)  NOT NULL,
  description     TEXT          NOT NULL,
  priorite        ENUM('basse', 'moyenne', 'haute') NOT NULL DEFAULT 'moyenne',
  statut          ENUM('ouvert', 'en_cours', 'resolu') NOT NULL DEFAULT 'ouvert',
  auteur          VARCHAR(60)   NOT NULL,
  technicien      VARCHAR(60)   DEFAULT NULL,
  dateresolution  DATETIME      DEFAULT NULL,
  PRIMARY KEY (noticket),
  KEY fk_ticket_secteur (secteur),
  KEY idx_ticket_statut (statut, priorite),
  CONSTRAINT fk_ticket_secteur    FOREIGN KEY (secteur)    REFERENCES secteur (code),
  CONSTRAINT fk_ticket_auteur     FOREIGN KEY (auteur)     REFERENCES agent (mel),
  CONSTRAINT fk_ticket_technicien FOREIGN KEY (technicien) REFERENCES agent (mel)
) ENGINE=InnoDB;
