IDENTIFICATION DIVISION.
PROGRAM-ID. AEROPROJ.
AUTHOR. MIMY.
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
	SELECT AVION ASSIGN TO "favion.dat"
	ORGANIZATION IS INDEXED
	RECORD KEY IS CODAV
	ALTERNATE RECORD KEY IS CODTYP WITH DUPLICATES.
	SELECT PILOTE ASSIGN TO "fpilot.dat"
	ORGANIZATION IS INDEXED
	RECORD KEY IS NUMPIL.
	SELECT VISITE ASSIGN TO "fvisit.dat"
	ORGANIZATION IS INDEXED
	RECORD KEY IS NUMVISIT.
	SELECT TYPEFILE ASSIGN TO "ftyp.dat"
	ORGANIZATION IS INDEXED
	RECORD KEY IS NUMTYP.
	SELECT TABLEFILE ASSIGN TO "ftabl.dat"
	ORGANIZATION IS INDEXED
	RECORD KEY IS PILTYP
	ALTERNATE RECORD KEY IS CODTYP WITH DUPLICATES
	ALTERNATE RECORD KEY IS CODPIL WITH DUPLICATES.
	SELECT VOL ASSIGN TO "fvol.dat"
	ORGANIZATION IS INDEXED
	RECORD KEY IS NUMVOL
	ALTERNATE RECORD KEY IS NUMPIL WITH DUPLICATES
	ALTERNATE RECORD KEY IS NUMAV WITH DUPLICATES.
	
DATA DIVISION.

WORKING-STORAGE SECTION.
77 NUMVISIT PIC 9.
77 NUMPIL PIC 9.
77 CODAV PIC 9.
77 CODTYP PIC 9.
77 NUMTYP PIC 9.
77 NUMPIL PIC 9.
77 NUMAV PIC 9.
77 NUMVOL PIC 9.
01 PILTYP.
	02 CODPIL PIC 9.
	02 CODTYP PIC 9.


**********************table adresse	
CREATE TABLE ADRESSE 
(
   ADRESSEID            integer                        not null,
   NUMERO               integer                        not null,
   TYPEVOIE             char(20)                       not null,
   NOMVOIE              char(50)                       not null,
   CODEPOSTAL           integer                        not null,
   VILLE                char(20)                       not null,
   PAYS                 char(20)                       not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   constraint PK_ADRESSE primary key (ADRESSEID));
   
CREATE TRIGGER TRIGADRESSE
ON TABLE ADRESSE
FOR INSERT
AS UPDATE ADRESSE
   SET DATCRE = DATE()
	   DATMAJ = DATE()
	   UTIL = USERID;

CREATE TRIGGER TRIGADRESSE
ON TABLE ADRESSE
FOR UPDATE
AS UPDATE ADRESSE
   SET DATMAJ = DATE()
	   UTIL = USERID;
	   
CREATE TRIGGER TRIGADRESSE
ON TABLE ADRESSE
FOR DELETE
AS UPDATE ADRESSE
   SET DATMAJ = DATE()
	   DATSUP = DATE()
	   UTIL = USERID;

***************************table etat avion	   
CREATE TABLE ETAT_AVION 
(
   NUMETATAV            char(1)                        not null,
   NOMETATAV            char(10)                       not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   USERID               integer                        not null,
   constraint PK_ETAT_AVION primary key (NUMETATAV)
   
CREATE TRIGGER TRIGETATAVION
ON TABLE ETAT_AVION
FOR INSERT
AS UPDATE ETAT_AVION
   SET DATCRE = DATE()
	   DATMAJ = DATE()
	   UTIL = USERID

CREATE TRIGGER TRIGETATAVION
ON TABLE ETAT_AVION
FOR UPDATE
AS UPDATE ETAT_AVION
   SET DATMAJ = DATE()
	   UTIL = USERID
	   
CREATE TRIGGER TRIGETATAVION
ON TABLE ETAT_AVION
FOR DELETE
AS UPDATE ETAT_AVION
   SET DATMAJ = DATE()
	   DATSUP = DATE()
	   UTIL = USERID
);

*********************table type
CREATE TABLE TYPES 
(
   NUMTYP               integer                        not null,
   DESIGN               char(20)                       not null,
   TARIF                float(2)                       not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   USERID               integer                        not null,
   constraint PK_TYPES primary key (NUMTYP));
   
CREATE TRIGGER TRIGTYPES
ON TABLE TYPES  
FOR INSERT
AS UPDATE TYPES 
   SET DATCRE = DATE()
	   DATMAJ = DATE()
	   UTIL = USERID

CREATE TRIGGER TRIGTYPES
ON TABLE TYPES 
FOR UPDATE
AS UPDATE TYPES 
   SET DATMAJ = DATE()
	   UTIL = USERID
	   
CREATE TRIGGER TRIGTYPES
ON TABLE TYPES 
FOR DELETE
AS UPDATE TYPES  
   SET DATMAJ = DATE()
	   DATSUP = DATE()
	   UTIL = USERID
;

******************table avion
CREATE TABLE AVIONS 
(
   CODAV                integer                        not null,
   CODTYP               char(2)                        FOREIGN KEY REFERENCES TYPES(NUMTYP),
   CPTHORAV             integer                        not null,
   CPTINTER             integer                        not null,
   INFOS                char(50)                       not null,
   ETATAV            	char(1)                        FOREIGN KEY REFERENCES ETAT_AVION(NUMETATAV),
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   USERID               integer                        not null,
   constraint PK_AVIONS primary key (CODAV)
   
CREATE TRIGGER TRIGAVIONS
ON TABLE AVIONS
FOR INSERT
AS UPDATE AVIONS
   SET DATCRE = DATE()
	   DATMAJ = DATE()
	   UTIL = USERID

CREATE TRIGGER TRIGAVIONS
ON TABLE AVIONS
FOR UPDATE
AS UPDATE AVIONS
   SET DATMAJ = DATE()
	   UTIL = USERID
	   
CREATE TRIGGER TRIGAVIONS
ON TABLE AVIONS
FOR DELETE
AS UPDATE AVIONS
   SET DATMAJ = DATE()
	   DATSUP = DATE()
	   UTIL = USERID
);

******************table civilité
CREATE TABLE CIVILITE 
(
   CIVID                integer                        not null,
   LIBELLE              char(20)                       not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   USERID               integer                        not null,
   constraint PK_CIVILITE primary key (CIVID));
   
CREATE TRIGGER TRIGCIVILITE
ON TABLE CIVILITE
FOR INSERT
AS UPDATE CIVILITE
   SET DATCRE = DATE()
	   DATMAJ = DATE()
	   UTIL = USERID;

CREATE TRIGGER TRIGCIVILITE
ON TABLE CIVILITE
FOR UPDATE
AS UPDATE CIVILITE
   SET DATMAJ = DATE()
	   UTIL = USERID;
	   
CREATE TRIGGER TRIGCIVILITE
ON TABLE CIVILITE
FOR DELETE
AS UPDATE CIVILITE
   SET DATMAJ = DATE()
	   DATSUP = DATE()
	   UTIL = USERID;

****************** table controle
CREATE TABLE CONTROLES 
(
   NUMCONTROL           integer                        not null,
   NUMAVION				integer						   FOREIGN KEY REFERENCES AVION(CODAV),
   DATECONTROL          char(10)                       not null,
   RESCONTROL           integer                        not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   USERID               integer                        not null,
   constraint PK_CONTROLES primary key (NUMCONTROL));
   
CREATE TRIGGER TRIGCONTROLES
ON TABLE CONTROLES
FOR INSERT
AS UPDATE CONTROLES
   SET DATCRE = DATE()
	   DATMAJ = DATE()
	   UTIL = USERID;

CREATE TRIGGER TRIGCONTROLES
ON TABLE CONTROLES
FOR UPDATE
AS UPDATE CONTROLES
   SET DATMAJ = DATE()
	   UTIL = USERID;
	   
CREATE TRIGGER TRIGCONTROLES
ON TABLE CONTROLES
FOR DELETE
AS UPDATE CONTROLES
   SET DATMAJ = DATE()
	   DATSUP = DATE()
	   UTIL = USERID;



******************table etat-pilote-presence
CREATE TABLE ETAT_PILOTE_PRESENCE 
(
   NUMPRESENCE          char(1)                        not null,
   NOMPRESENCE          char(10)                       not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   USERID               integer                        not null,
   constraint PK_ETAT_PILOTE_PRESENCE primary key (NUMPRESENCE));
   
CREATE TRIGGER TRIGETAPILPRES
ON TABLE ETAT_PILOTE_PRESENCE 
FOR INSERT
AS UPDATE ETAT_PILOTE_PRESENCE 
   SET DATCRE = DATE()
	   DATMAJ = DATE()
	   UTIL = USERID;

CREATE TRIGGER TRIGETAPILPRES
ON TABLE ETAT_PILOTE_PRESENCE 
FOR UPDATE
AS UPDATE ETAT_PILOTE_PRESENCE 
   SET DATMAJ = DATE()
	   UTIL = USERID;
	   
CREATE TRIGGER TRIGETAPILPRES
ON TABLE ETAT_PILOTE_PRESENCE 
FOR DELETE
AS UPDATE ETAT_PILOTE_PRESENCE 
   SET DATMAJ = DATE()
	   DATSUP = DATE()
	   UTIL = USERID;

******************table pilote-santé

CREATE TABLE ETAT_PILOTE_SANTE 
(
   NUMSANTE             char(1)                        not null,
   NOMSANTE             char(10)                       not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   USERID               integer                        not null,
   constraint PK_ETAT_PILOTE_SANTE primary key (NUMSANTE));
   
CREATE TRIGGER TRIGETAPILSAN
ON TABLE ETAT_PILOTE_SANTE 
FOR INSERT
AS UPDATE ETAT_PILOTE_SANTE
   SET DATCRE = DATE()
	   DATMAJ = DATE()
	   UTIL = USERID;

CREATE TRIGGER TRIGETAPILSAN
ON TABLE ETAT_PILOTE_SANTE 
FOR UPDATE
AS UPDATE ETAT_PILOTE_SANTE
   SET DATMAJ = DATE()
	   UTIL = USERID;
	   
CREATE TRIGGER TRIGETAPILSAN
ON TABLE ETAT_PILOTE_SANTE 
FOR DELETE
AS UPDATE ETAT_PILOTE_SANTE 
   SET DATMAJ = DATE()
	   DATSUP = DATE()
	   UTIL = USERID;

******************table etat pilote situation
CREATE TABLE ETAT_PILOTE_SITUATION 
(
   NUMSITUATION         char(1)                        not null,
   NOMSITUATION         char(10)                       not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   USERID               integer                        not null,
   constraint PK_ETAT_PILOTE_SITUATION primary key (NUMSITUATION));

CREATE TRIGGER TRIGETAPILSIT
ON TABLE ETAT_PILOTE_SITUATION 
FOR INSERT
AS UPDATE ETAT_PILOTE_SITUATION
   SET DATCRE = DATE()
	   DATMAJ = DATE()
	   UTIL = USERID;

CREATE TRIGGER TRIGETAPILSIT
ON TABLE ETAT_PILOTE_SITUATION
FOR UPDATE
AS UPDATE ETAT_PILOTE_SITUATION
   SET DATMAJ = DATE()
	   UTIL = USERID;
	   
CREATE TRIGGER TRIGETAPILSIT
ON TABLE ETAT_PILOTE_SITUATION
FOR DELETE
AS UPDATE ETAT_PILOTE_SITUATION 
   SET DATMAJ = DATE()
	   DATSUP = DATE()
	   UTIL = USERID;

******************TABLE PILOTES

CREATE TABLE PILOTES 
(
   NUMPIL               integer                        not null,
   NOM                  char(20)                       not null,
   PRENOM               char(20)                       not null,
   CIV                  integer                        FOREIGN KEY REFERENCES CIVILITE(CIVID),
   ADRESSE              char (50)                      FOREIGN KEY REFERENCES ADRESSE(ADRESSEID),
   NBHVOL               integer                        not null,
   ETAT_SANTE          	char(1)                        FOREIGN KEY REFERENCES ETAT_PILOTE_SANTE(NUMSANTE),
   ETAT_SIT          	char(1)                        FOREIGN KEY REFERENCES ETAT_PILOTE_SITUATION(NUMSITUATION),
   ETAT_PRES          	char(1)                        FOREIGN KEY REFERENCES ETAT_PILOTE_PRESENCE(NUMPRESENCE),
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   USERID               integer                        not null,
   constraint PK_PILOTES primary key (NUMPIL)
   
CREATE TRIGGER TRIGPILOTES
ON TABLE PILOTES  
FOR INSERT
AS UPDATE PILOTES 
   SET DATCRE = DATE()
	   DATMAJ = DATE()
	   UTIL = USERID

CREATE TRIGGER TRIGPILOTES
ON TABLE PILOTES 
FOR UPDATE
AS UPDATE PILOTES 
   SET DATMAJ = DATE()
	   UTIL = USERID
	   
CREATE TRIGGER TRIGPILOTES
ON TABLE PILOTES 
FOR DELETE
AS UPDATE PILOTES  
   SET DATMAJ = DATE()
	   DATSUP = DATE()
	   UTIL = USERID
);



******************table pilotage

CREATE TABLE PILOTAGE 
(
   NUMETYPE             integer                        not null,
   NUMPIL               integer                        FOREIGN KEY REFERENCES PILOTES(NUMPIL),
   DATEPILOTAGE         char(10)                       not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   USERID               integer                        not null,
   constraint PK_PILOTES primary key (NUMETYPE)
 
CREATE TRIGGER TRIGPILOTAGE
ON TABLE PILOTAGE  
FOR INSERT
AS UPDATE PILOTAGE 
   SET DATCRE = DATE()
	   DATMAJ = DATE()
	   UTIL = USERID

CREATE TRIGGER TRIGPILOTAGE
ON TABLE PILOTAGE 
FOR UPDATE
AS UPDATE PILOTAGE 
   SET DATMAJ = DATE()
	   UTIL = USERID
	   
CREATE TRIGGER TRIGPILOTAGE
ON TABLE PILOTAGE 
FOR DELETE
AS UPDATE PILOTAGE  
   SET DATMAJ = DATE()
	   DATSUP = DATE()
	   UTIL = USERID
);

*****************table visite

CREATE TABLE VISITES 
(
   NUMVISIT             integer                        not null,
   DATEVISIT            char(10)                       not null,
   RESULTAT             char(1)                        not null,
   TYPVISIT             char(1)                        not null,
   CODOBJ               integer                        FOREIGN KEY REFERENCES PILOTE(NUMPIL),
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   USERID               integer                        not null,
   constraint PK_VISITES primary key (NUMVISIT));
   
CREATE TRIGGER TRIGVISITES
ON TABLE VISITES 
FOR INSERT
AS UPDATE VISITES 
   SET DATCRE = DATE()
	   DATMAJ = DATE()
	   UTIL = USERID

CREATE TRIGGER TRIGVISITES
ON TABLE VISITES 
FOR UPDATE
AS UPDATE VISITES 
   SET DATMAJ = DATE()
	   UTIL = USERID
	   
CREATE TRIGGER TRIGVISITES
ON TABLE VISITES 
FOR DELETE
AS UPDATE VISITES  
   SET DATMAJ = DATE()
	   DATSUP = DATE()
	   UTIL = USERID
);

CREATE TABLE VOLS 
(
   NUMVOL               integer                        not null,
   DATEDEB              char(10)                       not null,
   DATEFIN              char(10)                       not null,
   CPTDEP               integer                        not null,
   CPTARR               integer                        not null,
   DESTIN               char(25)                       not null,
   ETATVOL              char(1)                        not null,
   NUMAV                integer                        FOREIGN KEY REFERENCES AVION(CODAV),
   NUMPIL               integer                        FOREIGN KEY REFERENCES PILOTES(NUMPIL),
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   USERID               integer                        not null,
   constraint PK_VOLS primary key (NUMVOL));
   
CREATE TRIGGER TRIGVOLS
ON TABLE VOLS 
FOR INSERT
AS UPDATE VOLS 
   SET DATCRE = DATE()
	   DATMAJ = DATE()
	   UTIL = USERID;

CREATE TRIGGER TRIGVOLS
ON TABLE VOLS 
FOR UPDATE
AS UPDATE VOLS 
   SET DATMAJ = DATE()
	   UTIL = USERID;
	   
CREATE TRIGGER TRIGVOLS
ON TABLE VOLS 
FOR DELETE
AS UPDATE VOLS  
   SET DATMAJ = DATE()
	   DATSUP = DATE()
	   UTIL = USERID;


PROCEDURE DIVISION.
PRINCIPAL SECTION.


FIN.
	STOP RUN.