IDENTIFICATION DIVISION.
PROGRAM-ID. F1.
DATA DIVISION.
WORKING-STORAGE SECTION.

77 I PIC 9 VALUE 0.
77 ERREURS PIC X(50) VALUE IS " ".
**** VARIABLES DE SAISIE
77 PIL_ID PIC Z(3).
77 DEST PIC X(25).
77 TYPE-VOL PIC Z(3).
77 CHOIX PIC X.

***** VARIABLES D'ERREUR
77 ERREURS PIC X(50) VALUE IS " ".

**** VARIABLES DE VALIDATION DU VOL
77 ETAT-GENERAL-PILOTE PIC 9 VALUE IS 0.
77 VOL-COMPATIBLE PIC 9 VALUE IS 0.
77 DISPO-PILOTE PIC 9 VALUE IS 0. 

**** DATE DU JOUR
01 WDATE.
   02 WANNEE PIC 99.
   02 WMOIS PIC 99.
   02 WJOUR PIC 99.

***** DATE DEPART VOL
01 DATE-DEPART.
   02 DJOUR PIC ZZ.
   02 FILLER PIX X VALUE "/".
   02 DMOIS PIC ZZ.
   02 FILLER PIX X VALUE "/".
   02 DANNEE PIC ZZ.
   02 FILLER PIX X VALUE " ".
   02 DHEURE PIC ZZ.
   02 FILLER PIX X VALUE ":".
   02 DMINUTE PIC ZZ.

**** DATE ARRIVEE VOL
01 DATE-ARRIVEE.
   02 AJOUR PIC ZZ.
   02 FILLER PIX X VALUE "/".
   02 AMOIS PIC ZZ.
   02 FILLER PIX X VALUE "/".
   02 AANNEE PIC ZZ.
   02 FILLER PIX X VALUE " ".
   02 AHEURE PIC ZZ.
   02 FILLER PIX X VALUE ":".
   02 AMINUTE PIC ZZ.
    

**** IMPORT SQLCA	
	EXEC SQL
		INCLUDE SQLCA
	END-EXEC.

**** IMPORT TABLE ETAT_PILOTE_SANTE
	EXEC SQL
		INCLUDE ETAT_PILOTE_SANTE
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.
		01 WS-SANTE-PILOTE
			05 WS-NUMSANTE PIC X.
			05 WS-NOMSANTE PIC X(10).
	
	EXEC SQL END DECLARE SECTION
	END-EXEC.

**** IMPORT TABLE ETAT_PILOTE_PRESENCE
	EXEC SQL
		INCLUDE ETAT_PILOTE_PRESENCE
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.
		01 WS-PRES-PILOTE
			05 WS-NUMPRESENCE PIC X.
			05 WS-NOMPRESENCE PIC X(10).
	
	EXEC SQL END DECLARE SECTION
	END-EXEC.

**** IMPORT TABLE ETAT_PILOTE_SITUATION	
	EXEC SQL
		INCLUDE ETAT_PILOTE_SITUATION
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.
		01 WS-SIT-PILOTE
			05 WS-NUMSITUATION PIC X.
			05 WS-NOMSITUATION PIC X(10).
	
	EXEC SQL END DECLARE SECTION
	END-EXEC.
	
**** IMPORT TABLE PILOTES	
	EXEC SQL
		INCLUDE PILOTES
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.
		05 WS-PILOTES.
			05 WS-NUMPIL PIC 9(2).
			05 WS-NOM PIC X(20).
			05 WS-PRENOM PIC X(20).
			05 WS-CIV PIC 9.
			05 WS-NBHVOL PIC 9(3).
			05 WS-ETAT_SANTE PIC X.
			05 WS-ETAT_SIT PIC X.
			05 WS-ETAT_PRES PIC X.
			05 WS-DATEMAJ PIC X(8).
	EXEC SQL END DECLARE SECTION
	END-EXEC.

**** IMPORT TABLE TYPES
	EXEC SQL
		INCLUDE TYPES
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.
		01 WS-TYPES.
			05 WS-NUMTYP PIC X(2).
			05 WS-DESIGN PIC X.
	EXEC SQL END DECLARE SECTION
	END-EXEC.

**** IMPORT TABLE VOLS	
	EXEC SQL
		INCLUDE VOLS
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.
		01 WS-VOLS.
			05 WS-NUMVOL PIC 9(3).
			05 WS-DATEDEB PIC X(10).
			05 WS-DATEFIN PIC X(10).
			05 WS-CPTDEP  PIC 9(6).
			05 WS-CPTARR PIC 9(6).
			05 WS-DESTIN PIC X(25).
			05 WS-ETATVOL PIC X(1).
			05 WS-NUMAV PIC 9(3).
			05 WS-NUMPIL PIC 9(3).
	EXEC SQL END DECLARE SECTION
	END-EXEC.
   
**** IMPORT TABLE PILOTAGE	
	EXEC SQL
		INCLUDE PILOTAGE
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.   
		01 PILOTAGE.
			05 WS-NUMETYPE PIC 9(3) VALUE IS 0.
			05 WS-NUMPIL PIC 9(3) VALUE IS 0.
			05 WS-DATEPILOTAGE PIC 9(10).
   EXEC SQL END DECLARE SECTION
	END-EXEC.

**** IMPORT TABLE AVIONS	
	EXEC SQL
		INCLUDE AVIONS
	END-EXEC.
		01 AVIONS.
			05 WS-CODAV PIC 9(3) VALUE IS 0.
			05 WS-CODTYP PIC X(2).
			05 WS-CPTHORAV PIC 9(6).
			05 WS-CPTINTER PIC 9(6).
			05 WS-INFOS PIC X(50).
			05 WS-ETATAV PIC X.
    EXEC SQL END DECLARE SECTION
	END-EXEC.
   
LINKAGE SECTION.   
SCREEN SECTION.
**** ECRAN DE SAISIE
  01  DELETE-SCREEN BLANK SCREEN.
  01  SCREEN-ACCUEIL.
      05 LINE 01 COL 01 VALUE "******************".
      05 LINE 02 COL 01 PIC 99 FROM WJOUR.
	  05 LINE 02 COL 03 VALUE "/".
	  05 LINE 02 COL 04 PIC 99 FROM WMOIS.
	  05 LINE 02 COL 06 VALUE "/P".
	  05 LINE 02 COL 07 PIC 99 FROM WANNEE.
      05 LINE 03 COL 01 VALUE "Application de gestion Aeroclub".
      05 LINE 04 COL 01 VALUE "DEPOT D'UN PLAN DE VOL".
      05 LINE 05 COL 01 VALUE "******************".
	  05 LINE 06 COL 01 VALUE "Veuillez entrer votre numéro de pilote :".
	  05 LINE 07 COL 01 PIC Z(3) TO PIL_ID.
	  05 LINE 09 COL 01 VALUE "Veuillez entrez une date de départ au format JJMMAAHHmm :" .
	  05 LINE 10 COL 01 PIC X(10) TO DATE-DEPART.
	  05 LINE 12 COL 01 VALUE "Veuillez entrez une date d'arrivée au format JJMMAAHHmm :" .
	  05 LINE 13 COL 01 PIC X(10) TO DATE-ARRIVEE.
	  05 LINE 15 COL 01 VALUE "Destination du vol :".
	  05 LINE 16 COL 01 PIC X(25) TO DEST.
	  05 LINE 17 COL 01 VALUE "Type du vol :".
	  05 LINE 18 COL 01 PIC Z(3) TO TYPE-VOL.
	  05 LINE 19 COL 01 VALUE "******************".   
      05 LINE 20 COL 01 PIC X(43) FROM ERREURS.
      05 LINE 21 COL 01 VALUE "REVENIR AU MENU(M) OU QUITTER (Q) :".
      05 LINE 22 COL 01 PIC X TO CHOIX.
	  
PROCEDURE DIVISION.

DEBUT.

PERFORM AFFICHE-ACCUEIL THRU EVALUATE-CHOIX.
	
AFFICHE-ACCUEIL.
	DISPLAY DELETE-SCREEN.
	ACCEPT WDATE FROM DATE.
    DISPLAY SCREEN-ACCUEIL.
    ACCEPT SCREEN-ACCUEIL.
   
AFFICHAGE-SAISIE.
	ACCEPT PIL_ID LINE 07 COL 01.
	ACCEPT DATE-DEPART LINE 10 COL 01.
	ACCEPT DATE-ARRIVEE LINE 13 COL 01.
	ACCEPT DEST LINE 16 COL 01.
	ACCEPT TYPE-VOL LINE 18 COL 01.
	ACCEPT CHOIX LINE 22 COL 01.



PLAN-DE-VOL.
***** Vérification de l'état du pilote (santé, présence, situation)
	EXEC SQL
		SELECT CIV, NOM, PRENOM, ETAT_SANTE, ETAT_PRES, ETAT_SIT
		INTO :WS-CIV, WS-NOM, WS-PRENOM, WS-ETAT_SANTE, WS-ETAT_PRES, WS-ETAT_SIT
		FROM PILOTES
		WHERE NUMPIL = PIL_ID
	END-EXEC.
	
	IF WS-ETAT_SANTE="A" AND WS-ETAT_PRES="P" AND WS-ETAT_PILOTE_SITUATION="L"
		MOVE 1 TO ETAT-GENERAL-PILOTE
	ELSE
		GO TO ANNULATION-PLAN-VOL
	END-IF.
	
***** Vérification type de vol COMPATIBLE

	EXEC SQL
		SELECT NUMETYPE, NUMPIL, DATEPILOTAGE FROM PILOTAGE
		INTO :WS-NUMETYPE, WS-NUMPIL, WS-DATEPILOTAGE
		WHERE NUMETYPE = TYPE-VOL
		AND NUMPIL = PIL_ID.
	END-EXEC.
	
	
****** V2RIFICATION ETAT AVION
*****LISTE AVIONS DU TYPE CHOISI EN ETAT
	EXEC SQL 
		SELECT CODAV
		INTO :WS-CODAV
		FROM AVION, VOL
		WHERE VOL.NUMAV=AVION.CODAV
		AND ETATAV="E"
		AND CODTYP=TYPE-VOL
		AND DATEFIN<DATE-DEPART
		AND DATEDEB>DATE-ARRIVEE
	END-EXEC.
	
	IF WS-NUMETYPE = 0 OR WS-CODAV = 0
		GO TO ANNULATION-PLAN-VOL
	ELSE 
		MOVE 1 TO VOL-COMPATIBLE
	END-IF.
	
	
*******VERIFICATION DISPONIBILIT2 PILOTE
	EXEC SQL 
		SELECT NUMPIL 
		INTO :WS-NUMPIL
		FROM PILOTES P, VOLS V
		WHERE P.NUMPIL = V.NUMPIL
		AND NUMPIL = PIL_ID
		AND V.DATEDEB > DATE-ARRIVEE
		AND V.DATEFIN < DATE-DEPART
	END-EXEC.
	
	IF WS:NUMPIL = 0
		GO TO ANNULATION-PLAN-VOL
	ELSE 
		MOVE 1 TO DISPO-PILOTE
	END-IF.

EDITION-PLAN-VOL.
	
******Création num vol
	EXEC SQL
		SELECT LAST(NUMVOL) 
		INTO : WS-NUMVOL
		FROM VOLS
	END-EXEC.

	ADD 1 TO WS-NUMVOL.
	
	DISPLAY "Plan de vol déposé :".
	DISPLAY "    Numéro de vol : " WS-NUMVOL.
	DISPLAY "    Date de départ : " DATE-DEPART.
	DISPLAY "    Date d'arrivée : " DATE-ARRIVEE.
	DISPLAY "    Destination : " DEST.
	DISPLAY "    Avion numéro : " WS-NUMAV.
	DISPLAY "    Pilote : " WS-CIV ". "WS-NOM " " WS-PRENOM.
	
******AJOUT DU VOL DANS LA BDD		

	EXEC SQL
		INSERT INTO VOLS(NUMVOL, DATEDEB, DATEFIN, DESTIN, ETATVOL, NUMAV, NUMPIL) 
		VALUES (:WS-NUMVOL , :DATE-DEPART, DATE-ARRIVEE, DEST, "D", WS-NUMAV, PIL_ID)
	END-EXEC.
	
ANNULATION-PLAN-VOL.
	"Le plan de vol ne peut être déposé pour le(s) raisons suivantes :" 
	IF DISPO-PILOTE = 0
		DISPLAY "    - Le pilote choisi n'est pas disponible." 
	END-IF.
	IF VOL-COMPATIBLE = 0
		DISPLAY "    - Le type d'avion choisi ne peut etre utilisé pour ce vol."
	END-IF.
	IF ETAT-GENERAL-PILOTE = 0
		DISPLAY "    - Le pilote n'est pas en etat d'assurer ce vol."
	END-IF.

EVALUATE-CHOIX.
	IF CHOIX="m" OR CHOIX="M"
		CALL "PAGE-ACCUEIL"
	ELSE IF CHOIX="Q" OR CHOIX="q"
		STOP RUN
	ELSE
		PERFORM ERREURS-CHOIX.
	END-IF.

ERREURS-CHOIX.
	ADD 1 TO I.
        IF I=3
			GO TO FIN
        ELSE 
            SUBTRACT I FROM 3 GIVING NB-ESSAI.
            MOVE "ERREUR, NOMBRE DE TENTATIVES RESTANTES : " TO ERREURS
            PERFORM DEBUT.
	
	
FIN.
    STOP RUN.