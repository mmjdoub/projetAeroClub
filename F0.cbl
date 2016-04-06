IDENTIFICATION DIVISION.
PROGRAM-ID. F0.
DATA DIVISION.
WORKING-STORAGE SECTION.
01  WDATE.
   02  WANNEE PIC 99.
   02  WMOIS PIC 99.
   02  WJOUR PIC 99.
01  WDATEMOIN.
   02  WJOURMOIN PIC 99.
   02  FILLER PIC X VALUE "/".
   02  WMOISMOIN PIC 99.
   02  FILLER PIC X VALUE "/".
   02  WANNEEMOIN PIC 99.

	EXEC SQL
		INCLUDE SQLCA
	END-EXEC.
	
	EXEC SQL
		INCLUDE AVIONS
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.
		01 WS-AVIONS.
			05 WS-CODAV PIC 9(2).
			05 WS-CODTYP PIC X (2).
			05 WS-CPTHORAV PIC 9(3).
			05 WS-CPTINTER PIC 9(3).
			05 WS-INFOS PIC X(50).
			05 WS-ETATAV PIC X.
	EXEC SQL END DECLARE SECTION
	END-EXEC.
	
	EXEC SQL
		INCLUDE ETAT_AVION
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.
	TABLE ETAT_AVION
		01 WS-ETAT-AVION.
			05 WS-NUMETATAV PIC X.
			05 WS-NOMETATAV PIC X(10).
	EXEC SQL END DECLARE SECTION
	END-EXEC.
	
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
	
	EXEC SQL
		INCLUDE CONTROLES
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.
		01 WS-CONTROLES.
			05 WS-NUMCONTROL PIC 9(3).
			05 WS-NUMAVIONPIC 9(3).
			05 WS-DATECONTROL PIC X(10).
			05 WS-RESCONTROL PIC 9.
	EXEC SQL END DECLARE SECTION
	END-EXEC.
	
	
	EXEC SQL
		INCLUDE VISITES
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.
		01 WS-VISITES.
			05 WS-NUMVISIT PIC 9(3).
			05 WS-DATEVISIT PIC X(10).
			05 WS-RESULTAT PIC X.
			05 WS-TYPVISIT PIC X.
			05 WS-CODOBJ PIC 9(3).
	EXEC SQL END DECLARE SECTION
	END-EXEC.
	
	EXEC SQL
		INCLUDE TYPES
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.
		01 WS-TYPES.
			05 WS-NUMTYP PIC 9(3).
			05 WS-DESIGN PIC X
	EXEC SQL END DECLARE SECTION
	END-EXEC.

LINKAGE SECTION.
SCREEN SECTION.
  01  SCREEN-F0.
	 05 LINE 01 COL 01 VALUE "******************".
     05 LINE 02 COL 01 PIC 99 FROM WJOUR.
	 05 LINE 02 COL 03 VALUE "/".
	 05 LINE 02 COL 04 PIC 99 FROM WMOIS.
	 05 LINE 02 COL 06 VALUE "/".
	 05 LINE 02 COL 07 PIC 99 FROM WANNEE.
     05 LINE 03 COL 01 VALUE "Application de gestion Aeroclub".
     05 LINE 04 COL 01 VALUE "Liste des avions à réviser et des pilotes malades".
     05 LINE 05 COL 01 VALUE "******************".
	 05 LINE 07 COL 01 VALUE "Liste des avions".
  
PROCEDURE DIVISION.
DEBUT.

AFFICHAGE.
   ACCEPT WDATE FROM DATE
   DISPLAY SCREEN-F0
   ACCEPT SCREEN-F0.

AVIONS.

	MOVE "O" TO WS-ETATAV.
	
	EXEC SQL
	UPDATE AVIONS SET ETATAV := WS-ETATAV, CPTINTER:=0
	FROM AVIONS 
		INNER JOIN TYPES ON AVIONS.CODTYP = TYPES.NUMTYP
		INNER JOIN CONTROLES ON CONTROLES.NUMAVION = AVIONS.CODAV
		WHERE CPTINTER < 500
	AND RESCONTROL = 2
	END-EXEC.
	
	
	EXEC SQL
	SELECT CODAV, DESIGN, RESCONTROL, CPTINTER
		INTO : WS-CODAV, WS-DESIGN, WS-RESCONTROL, WS-CPTINTER FROM AVIONS, TYPES, CONTROLES
		WHERE AVIONS.CODTYP = TYPES.NUMTYP
		AND CONTROLES.NUMAVION = AVIONS.CODAV
		AND CPTINTER < 500
		AND RESCONTROL = 2
	END-EXEC.
	
	IF SQLCODE=0
		DISPLAY  "Code avion : " WS-CODAV " Type avion " WS-DESIGN 
		-" Résultat du dernier contrôle" WS-RESCONTROL " Compteur intermédiaire : " WS-CPTINTER        
	END-IF.
	
PILOTES.
	MOVE WJOUR TO WJOURMOIN.
	MOVE WMOIS TO WMOISMOIN.
	COMPUTE WANNEEMOIN = WANNEE - 1.
	
	EXEC SQL
		UPDATE PILOTES SET ETAT_PILOTE_SANTE:="M" FROM PILOTES
		INNER JOIN VISITES ON PILOTES.NUMPIL = VISITES.CODOBJ
		INNER JOIN ETAT_PILOTE_PRESENCE PILOTES.ETAT_PRES = ETAT_PILOTE_PRESENCE.NUMPRESENCE
		WHERE DATEVISIT < WDATEMOIN
		AND RESULTAT = 2
		AND NOT(ETAT_PRES = "P" OR ETAT_PRES = "Q")
	END-EXEC.
	
	
	EXEC SQL
		SELECT NOM, PRENOM, DATEVISIT, RESULTAT FROM PILOTES, VISITES, ETAT_PILOTE_PRESENCE
		INTO WS-NOM, WS-PRENOM, WS-DATEVISIT, WS-RESULTAT
		WHERE PILOTES.NUMPIL = VISITES.CODOBJ
		AND PILOTES.ETAT_PRES = ETAT_PILOTE_PRESENCE.NUMPRESENCE
		AND DATEVISIT < WDATEMOIN
		AND RESULTAT = 2
		AND NOT(ETAT_PRES = "P" OR ETAT_PRES = "Q")
	END-EXEC.
	
	IF SQLCODE=0
		DISPLAY "Nom du pilote : "WS-NOM " " WS-PRENOM  " Date de la dernière visite : "
		- WS-DATEVISIT  "Résultat de la dernière visite : " WS-RESULTAT
	END-IF.
FIN.
	STOP RUN.