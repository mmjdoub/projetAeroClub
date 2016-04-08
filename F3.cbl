IDENTIFICATION DIVISION.
PROGRAM-ID. F3.
DATA DIVISION.
WORKING-STORAGE SECTION.
77 VALIDATION PIC X(42) VALUE IS " ".
77 CHOIX PIC X.
77 CHOIXACTION PIC X.
77 CHOIXVALIDATION PIC X.
77 I PIC 9 VALUE IS 0.
77 ERREURS PIC X(50) VALUE IS " ".
77 NB-ESSAI PIC Z VALUE IS 0.
77 NUMPILUSER PIC Z(3).
77 MAJ-NOM PIC X(20).
77 MAJ-PRENOM PIC X(20).
77 MAJ-NUMERO PIC Z(3).
77 MAJ-TYPEVOIE PIC X(20).
77 MAJ-NOMVOIE PIC X(50).
77 MAJ-CODEPOSTAL PIC Z(5).
77 MAJ-VILLE PIC X(20).
77 MAJ-PAYS PIC X(20).
77 MAJ-NUMETYPE PIC Z(3).

01 WDATE.
   02 WANNEE PIC 99.
   02 WMOIS PIC 99.
   02 WJOUR PIC 99.
   
****************************************    
	EXEC SQL
		INCLUDE SQLCA
	END-EXEC.
	
	EXEC SQL
		INCLUDE PILOTES
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.
		01 WS-PILOTES.
			05 WS-NUMPIL PIC Z(3).
			05 WS-NOM PIC X(20).
			05 WS-PRENOM PIC X(20).
			05 WS-CIV PIC 9(3).
			05 WS-ADRESSE PIC 9(3).
			05 WS-NBHVOL PIC Z(6).
			05 WS-ETAT_SANTE PIC X.
			05 WS-ETAT_SIT PIC X.
			05 WS-ETAT_PRES PIC X.
			
			
	EXEC SQL END DECLARE SECTION
	END-EXEC.
****************************************	
	EXEC SQL
		INCLUDE SQLCA
	END-EXEC.
	
	EXEC SQL
		INCLUDE CIVILITE
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.
		01 WS-CIVILITE.
			05 WS-CIVID PIC 9(3).
			05 WS-LIBELLE PIC X(20).
			
	EXEC SQL END DECLARE SECTION
	END-EXEC.
****************************************	
	EXEC SQL
		INCLUDE SQLCA
	END-EXEC.
	
	EXEC SQL
		INCLUDE ADRESSE
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.
		01 WS-ADRESSE.
			05 WS-ADRESSEID PIC 9(3).
			05 WS-NUMERO PIC Z(3).
			05 WS-TYPEVOIE PIC X(20).
			05 WS-NOMVOIE PIC X(50).
			05 WS-CODEPOSTAL PIC Z(5).
			05 WS-VILLE PIC X(20).
			05 WS-PAYS PIC X(20).
			
	EXEC SQL END DECLARE SECTION
	END-EXEC.
****************************************	
	EXEC SQL
		INCLUDE SQLCA
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
			05 WS-CODOBJ PIC 9(3).
			
			
	EXEC SQL END DECLARE SECTION
	END-EXEC.		
****************************************	
	EXEC SQL
		INCLUDE SQLCA
	END-EXEC.
	
	EXEC SQL
		INCLUDE TYPES
	END-EXEC.
	
	EXEC SQL BEGIN DECLARE SECTION
	END-EXEC.
		01 WS-PILOTAGE.
			05 WS-NUMETYPE PIC Z(3).?????????????????????????????????????????????????????
			05 WS-NUMPIL PIC 9(3).
			
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
      05 LINE 03 COL 01 VALUE "Application de gestion Aeroclub".
      05 LINE 04 COL 01 VALUE "MISE A JOUR DES PILOTES".
      05 LINE 05 COL 01 VALUE "******************".
	  05 LINE 07 COL 01 VALUE "1 : Créer un profil de pilote".
	  05 LINE 08 COL 01 VALUE "2 : Mettre à jour les informations du profil".
	  05 LINE 09 COL 01 VALUE "3 : Supprimer un profil".
	  05 LINE 10 COL 01 VALUE "4 : Ne rien faire".
	  05 LINE 11 COL 01 VALUE "Taper le chiffre correspondant à votre choix : ".
	  05 line 11 COL 48 PIC X TO CHOIXACTION.
	  05 LINE 19 COL 01 VALUE "******************".
	  05 LINE 20 COL 01 PIC X(50) FROM ERREURS.
	  05 LINE 20 COL 42 PIC Z FROM NB-ESSAI.
      05 LINE 21 COL 01 VALUE "REVENIR AU MENU (M) OU QUITTER (Q) :".
      05 LINE 22 COL 01 PIC X TO CHOIX.
	
  01  SCREEN-CREATION.
	  05 LINE 01 COL 01 VALUE "******************".
	  05 LINE 02 COL 01 PIC 99 FROM WJOUR.
	  05 LINE 02 COL 03 VALUE "/".
	  05 LINE 02 COL 04 PIC 99 FROM WMOIS.
	  05 LINE 02 COL 06 VALUE "/".
	  05 LINE 02 COL 07 PIC 99 FROM WANNEE.
	  05 LINE 03 COL 01 VALUE "Création d'un profil de pilote".
	  05 LINE 04 COL 01 VALUE "******************".
	  05 LINE 05 COL 01 VALUE "Civilité : ".
	  05 LINE 05 COL 12 PIC X(20) TO WS-LIBELLE.
	  05 LINE 06 COL 01 VALUE "Nom : ".
	  05 LINE 06 COL 07 PIC X(20) TO WS-NOM.
	  05 LINE 07 COL 01 VALUE "Prénom : ".
	  05 LINE 07 COL 10 PIC X(20) TO WS-PRENOM.
	  05 LINE 08 COL 01 VALUE "Numéro de voie : ".
	  05 LINE 08 COL 18 PIC Z(3) TO WS-NUMERO.
	  05 LINE 09 COL 01 VALUE "Type de voie : ".
	  05 LINE 09 COL 16 PIC X(20) TO WS-TYPEVOIE.
	  05 LINE 10 COL 01 VALUE "Nom de voie : ".
	  05 LINE 10 COL 15 PIC X(50) TO WS-NOMVOIE.
	  05 LINE 11 COL 01 VALUE "Code postal : ".
	  05 LINE 12 COL 15 PIC Z(5) TO WS-CODEPOSTAL.
	  05 LINE 12 COL 01 VALUE "Ville : ".
	  05 LINE 13 COL 09 PIC X(20) TO WS-VILLE.
	  05 LINE 13 COL 01 VALUE "Pays : ".
	  05 LINE 13 COL 08 PIC X(20) TO WS-PAYS.
	  05 LINE 14 COL 01 VALUE "Type d'avion possible de piloter : ".
	  05 LINE 14 COL 36 PIC Z(3) TO WS-NUMETYPE.???????????????????????????????????????????????????????
	  05 LINE 15 COL 01 VALUE "Nombres d'heures de vol : ".
	  05 LINE 15 COL 27 PIC Z(6) TO WS-NBHVOL.
	  05 LINE 16 COL 01 VALUE "Voulez-vous valider les informations saisies ? O/N ".
	  05 LINE 16 COL 52 PIC X TO CHOIXVALIDATION.
      05 LINE 19 COL 01 VALUE "******************".
	  05 LINE 20 COL 01 PIC X(50) FROM ERREURS.
	  05 LINE 21 COL 01 VALUE "REVENIR AU MENU (M) OU QUITTER (Q) : ".
      05 LINE 22 COL 01 PIC X TO CHOIX.
	  
  01  SCREEN-VALIDCREATION.
	  05 LINE 01 COL 01 VALUE "******************".
	  05 LINE 02 COL 01 PIC 99 FROM WJOUR.
	  05 LINE 02 COL 03 VALUE "/".
	  05 LINE 02 COL 04 PIC 99 FROM WMOIS.
	  05 LINE 02 COL 06 VALUE "/".
	  05 LINE 02 COL 07 PIC 99 FROM WANNEE.
	  05 LINE 03 COL 01 VALUE "Création d'un profil de pilote".
	  05 LINE 04 COL 01 VALUE "******************".
	  05 LINE 17 COL 01 PIC X(42) FROM VALIDATION.
	  05 LINE 17 COL 43 PIC Z(3) FROM WS-NUMPIL.
	  05 LINE 19 COL 01 VALUE "******************".
	  05 LINE 20 COL 01 PIC X(50) FROM ERREURS.
	  05 LINE 21 COL 01 VALUE "REVENIR AU MENU (M) OU QUITTER (Q) : ".
      05 LINE 22 COL 01 PIC X TO CHOIX.
	
  01  SCREEN-MAJ.
	  05 LINE 01 COL 01 VALUE "******************".
	  05 LINE 02 COL 01 PIC 99 FROM WJOUR.
	  05 LINE 02 COL 03 VALUE "/".
	  05 LINE 02 COL 04 PIC 99 FROM WMOIS.
	  05 LINE 02 COL 06 VALUE "/".
	  05 LINE 02 COL 07 PIC 99 FROM WANNEE.
	  05 LINE 03 COL 01 VALUE "******************".
	  05 LINE 04 COL 01 VALUE "Entrez votre numéro de pilote : ".
	  05 LINE 04 COL 33 PIC Z(3) TO NUMPILUSER.
	  05 LINE 05 COL 01 VALUE "Veuillez saisir chacune des informations suivantes ou les modifier.".
	  05 LINE 06 COL 01 PIC X(20) FROM WS-NOM.
	  05 LINE 06 COL 25 PIC X(20) TO MAJ-NOM.
	  05 LINE 07 COL 01 PIC X(20) FROM WS-PRENOM. 
	  05 LINE 07 COL 25 PIC X(20) TO MAJ-PRENOM.
	  05 LINE 08 COL 01 PIC 9(3) FROM WS-NUMERO. 
	  05 LINE 08 COL 25 PIC 9(3) TO MAJ-NUMERO.
	  05 LINE 09 COL 01 PIC X(20) FROM WS-TYPEVOIE.
	  05 LINE 09 COL 25 PIC X(20) TO MAJ-TYPEVOIE.	  
	  05 LINE 10 COL 01 PIC X(50) FROM WS-NOMVOIE. 
	  05 LINE 10 COL 25 PIC X(50) TO MAJ-NOMVOIE. 
	  05 LINE 11 COL 01 PIC 9(5) FROM WS-CODEPOSTAL.
	  05 LINE 11 COL 25 PIC 9(5) TO MAJ-CODEPOSTAL.
	  05 LINE 12 COL 01 PIC X(20) FROM WS-VILLE. 
	  05 LINE 12 COL 25 PIC X(20) TO MAJ-VILLE.
	  05 LINE 13 COL 01 PIC X(20) FROM WS-PAYS. 
	  05 LINE 13 COL 25 PIC X(20) TO MAJ-PAYS.
	  05 LINE 14 COL 01 PIC 9(3) FROM WS-NUMETYPE.????????????????????????????????????????? 
	  05 LINE 14 COL 25 PIC 9(3) TO MAJ-NUMETYPE.?????????????????????????????????????????
	  05 LINE 14 COL 01 VALUE "Voulez-vous valider les informations saisies ? O/N ".
	  05 LINE 14 COL 52 PIC X TO CHOIXVALIDATION.
	  05 LINE 19 COL 01 VALUE "******************".   
      05 LINE 20 COL 01 PIC X(50) FROM ERREURS.
      05 LINE 21 COL 01 VALUE "REVENIR AU MENU(M) OU QUITTER (Q) :".
      05 LINE 22 COL 01 PIC X TO CHOIX.
	  
  01  SCREEN-VALIDMAJ.
	  05 LINE 01 COL 01 VALUE "******************".
	  05 LINE 02 COL 01 PIC 99 FROM WJOUR.
	  05 LINE 02 COL 03 VALUE "/".
	  05 LINE 02 COL 04 PIC 99 FROM WMOIS.
	  05 LINE 02 COL 06 VALUE "/".
	  05 LINE 02 COL 07 PIC 99 FROM WANNEE.
	  05 LINE 03 COL 01 VALUE "******************".
	  05 LINE 15 COL 01 PIC X(42) FROM VALIDATION.
	  05 LINE 19 COL 01 VALUE "******************".   
      05 LINE 20 COL 01 PIC X(50) FROM ERREURS.
      05 LINE 21 COL 01 VALUE "REVENIR AU MENU(M) OU QUITTER (Q) :".
      05 LINE 22 COL 01 PIC X TO CHOIX.
	  
  01  SCREEN-SUPPRESSION.
	  05 LINE 01 COL 01 VALUE "******************".
	  05 LINE 02 COL 01 PIC 99 FROM WJOUR.
	  05 LINE 02 COL 03 VALUE "/".
	  05 LINE 02 COL 04 PIC 99 FROM WMOIS.
	  05 LINE 02 COL 06 VALUE "/".
	  05 LINE 02 COL 07 PIC 99 FROM WANNEE.
	  05 LINE 03 COL 01 VALUE "******************".
	  05 LINE 04 COL 01 VALUE "Entrez votre numéro de pilote : ".
	  05 LINE 04 COL 33 PIC Z(3) TO NUMPILUSER.
	  05 LINE 05 COL 01 VALUE "Désirez-vous vraiment effectuer une demande de départ ? O/N ".
	  05 LINE 05 COL 61 PIC X TO CHOIXVALIDATION.
      05 LINE 06 COL 01 PIC X(42) FROM VALIDATION.
	  05 LINE 19 COL 01 VALUE "******************".   
      05 LINE 20 COL 01 PIC X(50) FROM ERREURS.
      05 LINE 21 COL 01 VALUE "REVENIR AU MENU(M) OU QUITTER (Q) :".
      05 LINE 22 COL 01 PIC X TO CHOIX.
	
  01  SCREEN-VALIDSUPPRESSION.
	  05 LINE 01 COL 01 VALUE "******************".
	  05 LINE 02 COL 01 PIC 99 FROM WJOUR.
	  05 LINE 02 COL 03 VALUE "/".
	  05 LINE 02 COL 04 PIC 99 FROM WMOIS.
	  05 LINE 02 COL 06 VALUE "/".
	  05 LINE 02 COL 07 PIC 99 FROM WANNEE.
	  05 LINE 03 COL 01 VALUE "******************".
	  05 LINE 06 COL 01 PIC X(42) FROM VALIDATION.
	  05 LINE 19 COL 01 VALUE "******************".   
      05 LINE 20 COL 01 PIC X(50) FROM ERREURS.
      05 LINE 21 COL 01 VALUE "REVENIR AU MENU(M) OU QUITTER (Q) :".
      05 LINE 22 COL 01 PIC X TO CHOIX.

	   
PROCEDURE DIVISION.

DEBUT.
	PERFORM AFFICHAGE THRU EVALUATE-CHOIX.

AFFICHAGE.
	
	DISPLAY DELETE-SCREEN.
	ACCEPT WDATE FROM DATE.
    DISPLAY SCREEN-ACCUEIL.
    ACCEPT SCREEN-ACCUEIL.
	
MENU.
EVALUATE CHOIXACTION
    WHEN "1"
        PERFORM CREATION
    WHEN "2"
        PERFORM MAJ
    WHEN "3"
        PERFORM SUPPRESSION
	WHEN "4"
        PERFORM EVALUATE-CHOIX
	WHEN OTHER
	   MOVE "Erreur dans votre choix." TO ERREURS
	   GO TO DEBUT
END-EVALUATE.

EVALUATE-CHOIX.
	ACCEPT CHOIX LINE 22 COL 01
	
	IF CHOIX="m" OR CHOIX="M"
		CALL "PAGE-ACCUEIL"
	ELSE IF CHOIX="Q" OR CHOIX="q"
		STOP RUN
	ELSE
		PERFORM ERREURS-CHOIX
	END-IF. 
	
CREATION.
	DISPLAY DELETE-SCREEN.
	ACCEPT WDATE FROM DATE.
    DISPLAY SCREEN-CREATION.
    ACCEPT SCREEN-CREATION.
	ACCEPT WS-LIBELLE LINE 03 COL 12.
	ACCEPT WS-NOM LINE 4 COL 7.
	ACCEPT WS-PRENOM LINE 5 COL 10.
	ACCEPT WS-NUMERO LINE 6 COL 18.
	ACCEPT WS-TYPEVOIE LINE 7 COL 16.
	ACCEPT WS-NOMVOIE LINE 8 COL 15.
	ACCEPT WS-CODEPOSTAL LINE 9 COL 15.
	ACCEPT WS-VILLE LINE 10 COL 9.
	ACCEPT WS-PAYS LINE 11 COL 8.
	ACCEPT WS-NUMETYPE LINE 12 COL 36.???????????????????????????????????????????????????
	ACCEPT WS-NBHVOL LINE 13 COL 27.
	ACCEPT CHOIXVALIDATION LINE 14 COL 52.
	
	IF CHOIXVALIDATION = 'O' OR CHOIXVALIDATION = 'o' 
		
		EXEC SQL
			SELECT LAST(NUMPIL)
			INTO :WS-NUMPIL FROM PILOTES
		END-EXEC
		ADD 1 TO WS-NUMPIL
		MOVE WS-NUMPIL TO WS-CODOBJ
		
		EXEC SQL
			SELECT LAST(ADRESSEID)
			INTO :WS-ADRESSEID FROM ADRESSE
		END-EXEC
		ADD 1 TO WS-ADRESSEID
		
		EXEC SQL
			SELECT LAST(NUMVISIT)
			INTO :WS-NUMVISIT FROM VISITES
		END-EXEC
		ADD 1 TO WS-NUMVISIT
		
		EXEC SQL
			SELECT CIVID
			INTO :WS-CIVID FROM CIVILITE
			WHERE WS-LIBELLE = LIBELLE 
		END-EXEC.
		
		MOVE WS-CIVID TO CIVID.
		
		MOVE "A" TO WS-ETAT_SANTE
		MOVE "R" TO WS-ETAT_SIT
		MOVE "L" TO WS-PRES
		
		EXEC SQL
			INSERT INTO ADRESSE(ADRESSEID,NUMERO,TYPEVOIE,NOMVOIE,
			CODEPOSTAL,VILLE,PAYS)
			VALUES(:WS-ADRESSEID,:WS-NUMERO,WS-TYPEVOIE,WS-NOMVOIE,
			WS-CODEPOSTAL,WS-VILLE,WS-PAYS)
		END-EXEC
		
	    EXEC SQL
			INSERT INTO PILOTES(NUMPIL,NOM,PRENOM,CIV,ADRESSE,NBHVOL,
			ETAT_SANTE,ETAT_SIT,ETAT_PRES)
			VALUES(:WS-NUMPIL,:WS-NOM,WS-PRENOM,WS-CIV,WS-ADRESSE,WS-NBHVOL,
			WS-ETAT_SANTE,WS-ETAT_SIT,WS-ETAT_PRES)
		END-EXEC
		
		EXEC SQL
			INSERT INTO VISITES(NUMVISIT,CODOBJ)
			VALUES(:WS-NUMVISIT,:WS-CODOBJ)
		END-EXEC
	  
		IF NOT SQLCODE=0
			MOVE "ERREUR SQL" TO ERREURS
		END-IF
		
		MOVE "Profil créé. Votre numéro de pilote est : " TO VALIDATION
		DISPLAY DELETE-SCREEN
		ACCEPT WDATE FROM DATE
		DISPLAY SCREEN-VALIDCREATION
		ACCEPT SCREEN-VALIDCREATION
		ACCEPT CHOIX LINE 22 COL 01
		IF CHOIX="m" OR CHOIX="M"
			CALL "PAGE-ACCUEIL"
		ELSE 
			STOP RUN
		END-IF
	ELSE
		ACCEPT CHOIX LINE 22 COL 01
		IF CHOIX="m" OR CHOIX="M"
			CALL "PAGE-ACCUEIL"
		ELSE
			STOP RUN
		END-IF
	END-IF.	
	
MAJ.
	DISPLAY DELETE-SCREEN.
	ACCEPT WDATE FROM DATE.
    DISPLAY SCREEN-MAJ.
    ACCEPT SCREEN-MAJ.
	ACCEPT NUMPILUSER LINE 04 COL 33.
	EXEC SQL
		SELECT NUMPIL
		INTO :WS-NUMPIL FROM PILOTES
		WHERE NUMPILUSER = NUMPIL 
	END-EXEC.
	IF WS-NUMPIL = 0 
		PERFORM MAJ
	ELSE 
		EXEC SQL 
			SELECT NOM,PRENOM,ADRESSEID,NUMERO,TYPEVOIE,NOMVOIE,
			CODEPOSTAL,VILLE,PAYS,NUMETYPE
			INTO :WS-NOM,:WS-PRENOM,:WS-ADRESSEID,WS-NUMERO,WS-TYPEVOIE,WS-NOMVOIE,
			WS-CODEPOSTAL,WS-VILLE,WS-PAYS,:WS-NUMETYPE 
			FROM PILOTES, ADRESSE, PILOTAGE
			WHERE PILOTES.ADRESSE = ADRESSE.ADRESSEID
			AND PILOTES.NUMPIL = PILOTAGE.NUMETYPE
			AND PILOTES.NUMPIL = WS-NUMPIL
		END-EXEC
		
		ACCEPT MAJ-NOM PIC X(20) LINE 06 COL 25
		ACCEPT MAJ-PRENOM PIC X(20) LINE 07 COL 25
		ACCEPT MAJ-NUMERO PIC Z(3) LINE 08 COL 25
		ACCEPT MAJ-TYPEVOIE PIC X(20) LINE 09 COL 25
		ACCEPT MAJ-NOMVOIE PIC X(50) LINE 10 COL 25
		ACCEPT MAJ-CODEPOSTAL PIC Z(5) LINE 11 COL 25
		ACCEPT MAJ-VILLE PIC X(20) LINE 12 COL 25
		ACCEPT MAJ-PAYS PIC X(20) LINE 13 COL 25
		ACCEPT MAJ-NUMETYPE PIC Z(3) LINE 14 COL 25
		
		MOVE MAJ-NOM TO WS-NOM
		MOVE MAJ-PRENOM TO WS-PRENOM
		MOVE MAJ-NUMERO TO WS-NUMERO
		MOVE MAJ-TYPEVOIE TO WS-TYPEVOIE
		MOVE MAJ-NOMVOIE TO WS-NOMVOIE
		MOVE MAJ-CODEPOSTAL TO WS-CODEPOSTAL
		MOVE MAJ-VILLE TO WS-VILLE
		MOVE MAJ-PAYS TO WS-PAYS
		MOVE MAJ-NUMETYPE TO WS-NUMETYPE
		
		IF CHOIXVALIDATION = 'O' OR CHOIXVALIDATION = 'o' 
			EXEC SQL
				UPDATE PILOTES SET NOM=:WS-NOM, PRENOM=:WS-PRENOM
				WHERE NUMPIL = WS-NUMPIL
			END-EXEC.
		
			EXEC SQL
				UPDATE ADRESSE SET NUMERO=:WS-NUMERO, TYPEVOIE=:WS-TYPEVOIE,
				NOMVOIE=:WS-NOMVOIE, CODEPOSTAL=:WS-CODEPOSTAL, VILLE=:WS-VILLE,
				PAYS=:WS-PAYS
				WHERE ADRESSEID = WS-ADRESSEID
			END-EXEC.
			
			EXEC SQL
				UPDATE PILOTAGE SET NUMETYPE=:WS-NUMETYPE
				WHERE NUMPIL = WS-NUMPIL
			END-EXEC.
			
			IF NOT SQLCODE=0
				MOVE "ERREUR SQL" TO ERREURS
			END-IF
			
			MOVE "Les informations ont bien été modifiées." TO VALIDATION
			DISPLAY DELETE-SCREEN
			ACCEPT WDATE FROM DATE
			DISPLAY SCREEN-VALIDMAJ
			ACCEPT SCREEN-VALIDMAJ
			ACCEPT CHOIX LINE 22 COL 01
			IF CHOIX="m" OR CHOIX="M"
				CALL "PAGE-ACCUEIL"
			ELSE 
				STOP RUN
			END-IF
		ELSE 
			MOVE "Les informations n'ont pas été modifiées." TO VALIDATION
			DISPLAY DELETE-SCREEN
			ACCEPT WDATE FROM DATE
			DISPLAY SCREEN-VALIDMAJ
			ACCEPT SCREEN-VALIDMAJ
			ACCEPT CHOIX LINE 22 COL 01
			IF CHOIX="m" OR CHOIX="M"
				CALL "PAGE-ACCUEIL"
			ELSE 
				STOP RUN
			END-IF
		END-IF
	END-IF.
	
	
SUPPRESSION.
	DISPLAY DELETE-SCREEN.
	ACCEPT WDATE FROM DATE.
    DISPLAY SCREEN-SUPPRESSION.
    ACCEPT SCREEN-SUPPRESSION.
	ACCEPT NUMPILUSER LINE 04 COL 33.
	EXEC SQL
		SELECT NUMPIL
		INTO :WS-NUMPIL FROM PILOTES
		WHERE NUMPILUSER = NUMPIL 
	END-EXEC.
	
	IF WS-NUMPIL = 0 
		PERFORM SUPPRESSION
	ELSE 
		ACCEPT CHOIXVALIDATION LINE 05 COL 61
		IF CHOIXVALIDATION = 'O' OR CHOIXVALIDATION = 'o'
		
			MOVE "P" TO WS-ETAT_PRES
			
			EXEC SQL
				UPDATE PILOTES SET ETAT_PRES=:WS-ETAT_PRES
				WHERE NUMPIL = WS-NUMPIL
			END-EXEC
			
			MOVE "La demande de départ a bien été enregistrée." TO VALIDATION
			DISPLAY DELETE-SCREEN
			ACCEPT WDATE FROM DATE
			DISPLAY SCREEN-VALIDSUPPRESSION
			ACCEPT SCREEN-VALIDSUPPRESSION
			ACCEPT CHOIX LINE 22 COL 01
			IF CHOIX="m" OR CHOIX="M"
				CALL "PAGE-ACCUEIL"
			ELSE 
				STOP RUN
			END-IF
		ELSE 
			MOVE "La demande de départ n'a pas été enregistrée." TO VALIDATION
			DISPLAY DELETE-SCREEN
			ACCEPT WDATE FROM DATE
			DISPLAY SCREEN-VALIDSUPPRESSION
			ACCEPT SCREEN-VALIDSUPPRESSION
			ACCEPT CHOIX LINE 22 COL 01
			IF CHOIX="m" OR CHOIX="M"
				CALL "PAGE-ACCUEIL"
			ELSE 
				STOP RUN
			END-IF
			
		END-IF
		
	END-IF.


ERREURS-CHOIX.
	ADD 1 TO I.
        IF I=3
			GO TO FIN
        ELSE 
            SUBTRACT I FROM 3 GIVING NB-ESSAI.
            MOVE "Erreur, nombre de tentatives restantes : " TO ERREURS
            PERFORM DEBUT.
FIN.
	STOP RUN.