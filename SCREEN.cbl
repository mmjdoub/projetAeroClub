IDENTIFICATION DIVISION.
PROGRAM-ID. PAGE-ACCUEIL.
DATA DIVISION.
WORKING-STORAGE SECTION.
77 ERREURS PIC X(50) VALUE IS " ".
77 CHOIX PIC X VALUE IS " ".
77 I PIC 9 VALUE 0.
77 NB-ESSAI PIC Z.
01  WDATE.
   02  WANNEE PIC 99.
   02  WMOIS PIC 99.
   02  WJOUR PIC 99.
LINKAGE SECTION.
SCREEN SECTION.
  01  SCREEN-ACCUEIL.
      05 LINE 01 COL 01 VALUE "******************".
      05 LINE 02 COL 01 PIC 99 FROM WJOUR.
	  05 LINE 02 COL 03 VALUE "/".
	  05 LINE 02 COL 04 PIC 99 FROM WMOIS.
	  05 LINE 02 COL 06 VALUE "/".
	  05 LINE 02 COL 07 PIC 99 FROM WANNEE.
      05 LINE 03 COL 01 VALUE "Application de gestion Aeroclub".
      05 LINE 04 COL 01 VALUE "Fonction en cours : Présentation générale".
      05 LINE 05 COL 01 VALUE "******************".
      05 LINE 07 COL 01 VALUE "MENU :".
      05 LINE 09 COL 01 VALUE "0 : Liste des avions à réviser et des pilotes malades".
      05 LINE 10 COL 01 VALUE "1 : Dépôt d'un plan de vol".
      05 LINE 11 COL 01 VALUE "2 : Enregistrement d'un vol".
      05 LINE 12 COL 01 VALUE "3 : Mise à jour des pilotes".
      05 LINE 13 COL 01 VALUE "4 : Mise à jour des avions".
      05 LINE 14 COL 01 VALUE "5 : Récapitulatif avions".
      05 LINE 15 COL 01 VALUE "6 : Récapitulatif des pilotes".
      05 LINE 16 COL 01 VALUE "7 : Facturation des vols aux pilotes".
      05 LINE 19 COL 01 VALUE "******************".   
      05 LINE 20 COL 01 PIC X(43) FROM ERREURS.
      05 LINE 20 COL 45 PIC Z FROM NB-ESSAI.
      05 LINE 21 COL 01 VALUE "ENTREZ UN CHOIX OU QUITTER (Q) :".
      05 LINE 22 COL 01 PIC X TO CHOIX.
      
PROCEDURE DIVISION.

DEBUT.

PERFORM AFFICHE-ACCUEIL.
PERFORM MENU.

AFFICHE-ACCUEIL.
   ACCEPT WDATE FROM DATE
   DISPLAY SCREEN-ACCUEIL
   ACCEPT SCREEN-ACCUEIL.

MENU.
   EVALUATE CHOIX
    WHEN "0"
       CALL "F0"
    WHEN "1"
       CALL "F1"
    WHEN "2"
       CALL "F2"
    WHEN "3"
       CALL "F3"
    WHEN "4"
       CALL "F4"
    WHEN "5"
       CALL "F5"
    WHEN "6"
       CALL "F6"
    WHEN "7"
       CALL "F7"
    WHEN "Q"
       STOP RUN
    WHEN "q"
       STOP RUN   
    WHEN OTHER
        PERFORM ERREUR
END-EVALUATE.

ERREUR.
    ADD 1 TO I.
    IF I=3
        GO TO FIN
    ELSE 
        SUBTRACT I FROM 3 GIVING NB-ESSAI.
        MOVE "ERREUR, NOMBRE DE TENTATIVES RESTANTES : " TO ERREURS
        PERFORM AFFICHE-ACCUEIL THRU MENU.

FIN.
   STOP RUN.