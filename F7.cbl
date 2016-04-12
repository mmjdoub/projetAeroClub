IDENTIFICATION DIVISION.
PROGRAM-ID. F7.
DATA DIVISION.
WORKING-STORAGE SECTION.
	77 PERIOD1 PIC Z(6).
	77 PERIOD2 PIC Z(6).
	77 SUIVANT PIC X.
	
	77 CHOIX PIC X.
	77 ERREURS PIC X(50) VALUE IS " ".
	77 NB-ESSAI PIC Z VALUE IS 0.
	77 I PIC 9 VALUE IS 0.

	01 WDATE.
	   02 WANNEE PIC 99.
	   02 WMOIS PIC 99.
	   02 WJOUR PIC 99.
	   
	EXEC SQL
		INCLUDE SQLCA
	END-EXEC.
	
	EXEC SQL
		INCLUDE VOLS,TYPES
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.
		01 WS-VOLSTYPES. 
			05 WS-NUMVOL PIC 9(6).
			05 WS-DATEDEB PIC X(10).
			05 WS-DATEFIN PIC X(10).
			05 WS-CPTDEP PIC Z(6).
			05 WS-CPTARR PIC Z(6).
			05 WS-DESTIN PIC X(25).
			05 WS-ETATVOL PIC X.
			05 WS-NUMAV PIC Z(3).
			05 WS-NUMPIL PIC 9(3).
			05 WS-TARIF PIC ZZVZZ.
			05 WS-TOTALVOLAV PIC Z(6)VZZ.
			05 WS-NBHVOL PIC Z(6).
			05 WS-COUTVOL PIC Z(4)VZZ.
		
	EXEC SQL END DECLARE SECTION
	END-EXEC.
	   
LINKAGE SECTION.
SCREEN SECTION.
  01 DELETE-SCREEN BLANK SCREEN.
  01  SCREEN-ACCUEIL.
      05 LINE 01 COL 01 VALUE "******************".
      05 LINE 02 COL 01 PIC 99 FROM WJOUR. 
	  05 LINE 02 COL 03 VALUE "-".
	  05 LINE 02 COL 04 PIC 99 FROM WMOIS.
	  05 LINE 02 COL 06 VALUE "-".
	  05 LINE 02 COL 07 PIC 99 FROM WANNEE.
      05 LINE 03 COL 33 VALUE "FACTURATION DES VOLS".
      05 LINE 04 COL 28 VALUE "Periode du ".
	  05 LINE 04 COL 39 PIC Z(6) TO PERIOD1.
	  05 LINE 04 COL 46 VALUE "au ".
	  05 LINE 04 COL 49 PIC Z(6) TO PERIOD2.
	  05 LINE 05 COL 13 VALUE "N. avion ".
	  05 LINE 05 COL 60 VALUE "Tarif".
	  05 LINE 07 COL 07 VALUE "  Dates        |".
	  05 LINE 08 COL 23 VALUE "       Destination       |".
	  05 LINE 08 COL 01 VALUE "---------------------|".
	  05 LINE 07 COL 48 VALUE "| Cmpteur hor.|".
	  05 LINE 07 COL 70 VALUE "|".
	  05 LINE 08 COL 64 VALUE "H vol |".
	  05 LINE 08 COL 72 VALUE "Cout vol".
	  05 LINE 08 COL 49 VALUE "-------------|".
	  05 LINE 09 COL 02 VALUE " Depart  |".
	  05 LINE 09 COL 12 VALUE "  Arrivee |".
	  05 LINE 09 COL 48 VALUE "| Dep. |". 
	  05 LINE 09 COL 57 VALUE "Arr. |".
	  05 LINE 09 COL 70 VALUE "|".
	  05 LINE 16 COL 54 VALUE "Total vols avion".
	  05 LINE 19 COL 01 VALUE "******************".
	  05 LINE 20 COL 01 PIC X(50) FROM ERREURS.
	  05 LINE 20 COL 42 PIC Z FROM NB-ESSAI.
      05 LINE 21 COL 01 VALUE "REVENIR AU MENU (M) OU QUITTER (Q) :".
      05 LINE 22 COL 01 PIC X TO CHOIX.
	 
  01  SCREEN-FACTURE.
      05 LINE 01 COL 01 VALUE "******************".
      05 LINE 02 COL 01 PIC 99 FROM WJOUR. 
	  05 LINE 02 COL 03 VALUE "-".
	  05 LINE 02 COL 04 PIC 99 FROM WMOIS.
	  05 LINE 02 COL 06 VALUE "-".
	  05 LINE 02 COL 07 PIC 99 FROM WANNEE.
      05 LINE 03 COL 33 VALUE "FACTURATION DES VOLS".
      05 LINE 04 COL 28 VALUE "Periode du ".
	  05 LINE 04 COL 39 PIC Z(6) FROM PERIOD1.
	  05 LINE 04 COL 46 VALUE "au ".
	  05 LINE 04 COL 49 PIC Z(6) FROM PERIOD2.
	  05 LINE 05 COL 13 VALUE "N. avion ".
	  05 LINE 05 COL 22 PIC Z(3) FROM WS-NUMAV.
	  05 LINE 05 COL 60 VALUE "Tarif".
	  05 LINE 05 COL 66 PIC ZZVZZ FROM WS-TARIF.
	  05 LINE 07 COL 07 VALUE "  Dates        |".
	  05 LINE 08 COL 23 VALUE "       Destination       |".
	  05 LINE 08 COL 01 VALUE "---------------------|".
	  05 LINE 07 COL 48 VALUE "| Cmpteur hor.|".
	  05 LINE 07 COL 70 VALUE "|".
	  05 LINE 08 COL 64 VALUE "H vol |".
	  05 LINE 08 COL 72 VALUE "Cout vol".
	  05 LINE 08 COL 49 VALUE "-------------|".
	  05 LINE 09 COL 02 VALUE " Depart  |".
	  05 LINE 09 COL 12 VALUE "  Arrivee |".
	  05 LINE 09 COL 48 VALUE "| Dep. |". 
	  05 LINE 09 COL 57 VALUE "Arr. |".
	  05 LINE 09 COL 70 VALUE "|".
	  05 LINE 10 COL 01 PIC X(10) FROM WS-DATEDEB.
	  05 LINE 10 COL 12 PIC X(10) FROM WS-DATEFIN.
	  05 LINE 10 COL 23 PIC X(25) FROM WS-DESTIN.
	  05 LINE 10 COL 49 PIC Z(6) FROM WS-CPTDEP.
	  05 LINE 10 COL 56 PIC Z(6) FROM WS-CPTARR.
	  05 LINE 10 COL 63 PIC Z(6) FROM WS-NBHVOL.
	  05 LINE 10 COL 71 PIC Z(4)VZZ FROM WS-COUTVOL.
	  05 LINE 16 COL 54 VALUE "Total vols avion".
	  05 LINE 16 COL 71 PIC Z(6)VZZ FROM WS-TOTALVOLAV.
	  05 LINE 19 COL 01 VALUE "******************".
	  05 LINE 20 COL 01 PIC X(50) FROM ERREURS.
	  05 LINE 20 COL 42 PIC Z FROM NB-ESSAI.
      05 LINE 21 COL 01 VALUE "REVENIR AU MENU (M) OU QUITTER (Q) :".
      05 LINE 22 COL 01 PIC X TO CHOIX.

	 
PROCEDURE DIVISION.

DEBUT.

AFFICHAGE.
	DISPLAY DELETE-SCREEN.
	ACCEPT WDATE FROM DATE.
    DISPLAY SCREEN-ACCUEIL.
	ACCEPT PERIOD1 LINE 04 COL 26.
	ACCEPT PERIOD2 LINE 04 COL 36. 
	
FACTURATION.

	EXEC SQL
		DECLARE VOLTYPCUR CURSOR FOR
		SELECT NUMAV,TARIF,DATEDEB,DATEFIN,DESTIN,CPTDEP,
		CPTARR FROM AVIONS,VOLS,TYPES
		WHERE TYPES.NUMTYP = AVIONS.CODTYP
		AND   VOLS.NUMAV = AVIONS.CODAV
		AND	  DATEDEB>=PERIOD1 AND DATEFIN<=PERIOD2
	END-EXEC.
	
	EXEC SQL
		OPEN VOLTYPCUR
	END-EXEC.
	
	EXEC SQL
		CLOSE VOLTYPCUR
	END-EXEC.
  
    PERFORM UNTIL SQLCODE=100 
		
		EXEC SQL
			FETCH VOLTYPCUR
			INTO :WS-NUMAV,:WS-TARIF,:WS-DATEDEB,WS-DATEFIN,WS-DESTIN,
			WS-CPTDEP,WS-CPTARR
		END-EXEC
	
	
EVALUATE-CHOIX.
	ACCEPT CHOIX LINE 22 COL 01.
	IF CHOIX="m" OR CHOIX="M"
		CALL "PAGE-ACCUEIL"
	ELSE IF CHOIX="Q" OR CHOIX="q"
		STOP RUN
	ELSE
		PERFORM ERREURS-CHOIX
	END-IF.

ERREURS-CHOIX.
	ADD 1 TO I.
        IF I=3
			GO TO FIN
        ELSE 
            SUBTRACT I FROM 3 GIVING NB-ESSAI
            MOVE "ERREUR, NOMBRE DE TENTATIVES RESTANTES : " TO ERREURS
            PERFORM DEBUT.
	
FIN.
	STOP RUN.