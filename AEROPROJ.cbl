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
	
create table ADRESSE 
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
   constraint PK_ADRESSE primary key (ADRESSEID)
);

create table AVIONS 
(
   CODAV                integer                        not null,
   CODTYP               char(2)                        not null,
   CPTHORAV             integer                        not null,
   CPTINTER             integer                        not null,
   INFOS                char(50)                       not null,
   ETATAV               char(1)                        not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   constraint PK_AVIONS primary key (CODAV)
);

create table CIVILITE 
(
   CIVID                integer                        not null,
   LIBELLE              char(20)                       not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   constraint PK_CIVILITE primary key (CIVID)
);

create table CONTROLES 
(
   NUMCONTROL           integer                        not null,
   DATECONTROL          char(10)                       not null,
   RESCONTROL           integer                        not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   constraint PK_CONTROLES primary key (NUMCONTROL)
);

create table ETAT_AVION 
(
   NUMETATAV            char(1)                        not null,
   NOMETATAV            char(10)                       not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   constraint PK_ETAT_AVION primary key (NUMETATAV)
);

create table ETAT_PILOTE_PRESENCE 
(
   NUMPRESENCE          char(1)                        not null,
   NOMPRESENCE          char(10)                       not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   constraint PK_ETAT_PILOTE_PRESENCE primary key (NUMPRESENCE)
);

create table ETAT_PILOTE_SANTE 
(
   NUMSANTE             char(1)                        not null,
   NOMSANTE             char(10)                       not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   constraint PK_ETAT_PILOTE_SANTE primary key (NUMSANTE)
);

create table ETAT_PILOTE_SITUATION 
(
   NUMSITUATION         char(1)                        not null,
   NOMSITUATION         char(10)                       not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   constraint PK_ETAT_PILOTE_SITUATION primary key (NUMSITUATION)
);

create table PILOTAGE 
(
   NUMETYPE               integer                        not null,
   NUMPIL               integer                        not null,
   DATEPILOTAGE         char(10)                       not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   constraint PK_PILOTES primary key (NUMETYPE)
);

create table PILOTES 
(
   NUMPIL               integer                        not null,
   NOM                  char(20)                       not null,
   PRENOM               char(20)                       not null,
   CIV                  integer                        not null,
   ADRESSE              char (50)                      not null,
   NBHVOL               integer                        not null,
   ETAT_PILOTE          char(3)                        not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   constraint PK_PILOTES primary key (NUMPIL)
);

create table TYPES 
(
   NUMTYP               integer                        not null,
   DESIGN               char(20)                       not null,
   TARIF                float(2)                       not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   constraint PK_TYPES primary key (NUMTYP)
);

create table VISITES 
(
   NUMVISIT             integer                        not null,
   DATEVISIT            char(10)                       not null,
   RESULTAT             char(1)                        not null,
   TYPVISIT             char(1)                        not null,
   CODOBJ               integer                        not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   constraint PK_VISITES primary key (NUMVISIT)
);

create table VOLS 
(
   NUMVOL               integer                        not null,
   DATEDEB              char(10)                       not null,
   DATEFIN              char(10)                       not null,
   CPTDEP               integer                        not null,
   CPTARR               integer                        not null,
   DESTIN               char(25)                       not null,
   ETATVOL              char(1)                        not null,
   NUMAV                integer                        not null,
   NUMPIL               integer                        not null,
   DATCRE               char(8)                        not null,
   DATMAJ				char(8)						   not null,
   DATSUP				char(8)						   not null,
   constraint PK_VOLS primary key (NUMVOL)
);

PROCEDURE DIVISION.
PRINCIPAL SECTION.


FIN.
	STOP RUN.