

DROP DATABASE IF EXISTS villagegreen;

CREATE DATABASE villagegreen;


-- Table: rubrique --

USE villagegreen;
CREATE TABLE rubrique(
        rubrique_id   Int  Auto_increment  NOT NULL primary key,
        rubrique_nom  Varchar (50) NOT NULL,
        rubrique_desc Varchar (50) NOT NULL
        );



-- Table: sous_rubrique --


CREATE TABLE sous_rubrique(
        sousrub_id   Int  Auto_increment  NOT NULL PRIMARY KEY,
        sousrub_nom  Varchar (50) NOT NULL,
        sousrub_desc Varchar (50) NOT NULL,
        sousrub_rubrique_id  Int NOT null,
        FOREIGN KEY (sousrub_rubrique_id) REFERENCES rubrique(rubrique_id)
        );


-- Table: Produit --


CREATE TABLE Produit(
        produit_id             Int  Auto_increment  NOT NULL PRIMARY KEY,
        produit_nom_court      Char (50) NOT NULL,
        produit_nom            Varchar (255) NOT NULL,
        produit_photo          Varchar (255) NOT NULL,
        produit_qtite          Int NOT NULL,
        produit_prix_HT        DECIMAL(15,2) NOT NULL,
        produit_qtite_ale      Int NOT NULL,
        produit_sousrub_id     Int NOT NULL,
        FOREIGN KEY (produit_sousrub_id) REFERENCES sous_rubrique(sousrub_id)
	);



-- Table: fournisseur --


CREATE TABLE fournisseur(
        fournisseur_id             Int  Auto_increment  NOT NULL PRIMARY KEY,
        fournisseur_nom            Varchar (50) NOT NULL,
        fournisseur_rue            Varchar (50) NOT NULL,
        fournisseur_cp             Int NOT NULL,
        fournisseur_ville          Varchar (50) NOT NULL,
        fournisseur_tel            Char (14) NOT NULL,
        fournisseur_nom_contact    Varchar (50) NOT NULL,
        fournisseur_prenom_contact Varchar (50) NOT NULL
);



-- Table: client --


CREATE TABLE client(
        client_id               Int  Auto_increment  NOT NULL PRIMARY KEY,
        client_nom              Varchar (50) NOT NULL,
        client_prenom           VARCHAR (50) NOT NULL,
        client_rue              Varchar (50) NOT NULL,
        client_ville            Varchar (50) NOT NULL,
        client_codepo           INT NOT NULL,
        client_telephone        Varchar (14) NOT NULL,
        client_mail             Varchar (50) NOT NULL,        
        client_type             CHAR (50) NOT NULL,
        client_siret            CHAR (50),
        client_commerciaux_id   INT 
);



-- Table: commerciaux -- 


CREATE TABLE commerciaux(
        commerciaux_id     Int  Auto_increment  NOT NULL PRIMARY KEY,
        commerciaux_nom    Varchar (50) NOT NULL,
        commerciaux_prenom Varchar (50) NOT NULL,
        commerciaux_tel    CHAR (14) NOT NULL,
        commerciaux_mail   VARCHAR (50)
);



-- Table: commande --


CREATE TABLE commande(
        commande_id                           INT Auto_increment NOT NULL PRIMARY KEY,
        commande_date                         DATE NOT NULL,
        commande_reduc                        INT NOT NULL,
        commande_prix_tot                     DECIMAL(15,2) NOT NULL,
        commande_date_regle                   DATE NOT NULL,
        commande_date_facture                 DATE NOT NULL,  
        commande_livraison_codepo             CHAR(5) NOT NULL,     
        commande_livraison_rue                VARCHAR (50) NOT NULL,
        commande_livraison_ville              CHAR (50) NOT NULL,
        commande_facturation_rue              Varchar (50) NOT NULL,
        commande_facturation_ville            Varchar (50) NOT NULL,
        commande_facturation_codepo           CHAR(5) NOT NULL,
        commande_etat                         VARCHAR(10),
        commande_client_id                    Int NOT NULL,
        FOREIGN KEY (commande_client_id) REFERENCES client(client_id)
);



-- Table: livraison --


CREATE TABLE livraison(
        livraison_id            INT  Auto_increment  NOT NULL PRIMARY KEY, 
        livraison_num_bon       INT(11) NOT NULL,
        livraison_date          DATE NOT NULL,
        livraison_commande_id   INT NOT NULL,
        livraison_etat          VARCHAR (10),
        FOREIGN KEY (livraison_commande_id) REFERENCES commande(commande_id)
);



-- Table: appro --


CREATE TABLE appro(
        appro_fournisseur_id   INT NOT NULL,
        appro_produit_id       INT NOT NULL,
        appro_prix_achat       DECIMAL(7,2 ) NOT NULL,
        appro_date_com         DATE NOT NULL,
        appro_date_livr        DATE NOT NULL,
        appro_qtite            INT NOT NULL,
        appro_id               INT NOT NULL PRIMARY KEY,
        -- PRIMARY KEY (appro_fournisseur_id,appro_produit_id),
        FOREIGN KEY (appro_fournisseur_id) REFERENCES fournisseur(fournisseur_id),
        FOREIGN KEY (appro_produit_id) REFERENCES produit(produit_id)
);



-- Table: se compose de --


CREATE TABLE secomposede(
        secomposede_id            INT NOT NULL PRIMARY KEY,
        secomposede_commande_id   INT NOT NULL,
        secomposede_produit_id    INT NOT NULL,
        secomposede_qtite_commande INT NOT NULL,
        secomposede_prix_vente     DECIMAL(15,2)NOT NULL,
        
        FOREIGN KEY (secomposede_commande_id) REFERENCES commande(commande_id),
        FOREIGN KEY (secomposede_produit_id)  REFERENCES produit(produit_id)
);


-- Table: contient --


CREATE TABLE contient (
        contient_livraison_id INT,
        contient_produit_id INT,
        contient_qtite_liv INT,
        PRIMARY KEY (contient_livraison_id,contient_produit_id),
        FOREIGN KEY (contient_livraison_id) REFERENCES livraison(livraison_id),
        FOREIGN KEY (contient_produit_id) REFERENCES produit (produit_id)
);


-- Table: suivi par --  


CREATE TABLE suivipar (
        suivipar_client_id INT,
        suivipar_commerciaux_id INT,
        PRIMARY KEY (suivipar_client_id,suivipar_commerciaux_id),
        FOREIGN KEY (suivipar_client_id) REFERENCES client (client_id),
        FOREIGN KEY (suivipar_commerciaux_id) REFERENCES commerciaux (commerciaux_id)
); 