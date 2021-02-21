/* ---------------------Liste des utilisateurs pour Village green---------------------------- */

USE villagegreen;

/*----------- visiteur ------------*/

CREATE USER 'visiteur'@'%' IDENTIFIED BY 'visiteur1';

/*----------- lecture sur le catalogue (produit)------------*/

GRANT SELECT 
ON villagegreen.produit
TO visiteur
IDENTIFIED BY 'visiteur1';



/* ---------- client ------------- */

CREATE USER 'client1'@'%' IDENTIFIED BY 'client1';

/*-----------  lecture sur toute la base ------------*/

GRANT SELECT
ON *
TO client1
IDENTIFIED BY 'client1';

/* --------------insertion et mise à jour dans commande et client------------------------*/

GRANT INSERT,UPDATE
ON villagegreen.commande
TO client1
IDENTIFIED BY 'client1';

GRANT INSERT,UPDATE
ON villagegreen.client
TO client1
IDENTIFIED BY 'client1';



/* ---------- gestion ------------- */

CREATE USER 'gestion1'@'%' IDENTIFIED BY 'gest1';

/* -------------lecture écriture dans la base-------------------- */

GRANT SELECT,INSERT,UPDATE
ON *
TO gestion1
IDENTIFIED BY 'gest1';

/* -------------------administrateur --------------------- */

CREATE USER 'admin'@'%' IDENTIFIED BY 'admin1';

/* -------------- tous les droits dans villagegreen----------------- */

GRANT ALL PRIVILEGES 
ON villagegreen.*
TO admin 
IDENTIFIED BY 'admin1';