IDENTIFICATION DIVISION.
PROGRAM-ID. PAGE-ACCUEIL.
DATA DIVISION.
WORKING-STORAGE SECTION.
77 ERREURS PIC X(50) VALUE IS " ".
77 CHOIX PIC X VALUE IS " ".
77 QUITTER PIC 9 VALUE 1.
01  WDATE.
   02  WJOUR PIC 99.
   02  FILLER PIC X VALUE "/".
   02  WMOIS PIC 99.
   02  FILLER PIC X VALUE "/".
   02  WANNEE PIC 99.
LINKAGE SECTION.
SCREEN SECTION.
  01  SCREEN-ACCUEIL.
      05 LINE 01 COL 01 VALUE "******************".
      05 LINE 02 COL 01 PIC X(10) FROM WDATE.
      05 LINE 03 COL 01 VALUE "Application de gestion aeroclub".
      05 LINE 04 COL 01 VALUE "Fonction en cours : presentation generale".
      05 LINE 05 COL 01 VALUE "******************".
      05 LINE 07 COL 01 VALUE "MENU :".
      05 LINE 09 COL 01 VALUE "0 : liste des avions à réviser et des pilotes malades".
      05 LINE 10 COL 01 VALUE "1 : dépôt d'un plan de vol".
      05 LINE 11 COL 01 VALUE "2 : enregistrement d'un vol".
      05 LINE 12 COL 01 VALUE "3 : mise-à-jour des pilotes".
      05 LINE 13 COL 01 VALUE "4 : mise à jour des avions".
      05 LINE 14 COL 01 VALUE "5 : récapitulatif avions".
      05 LINE 15 COL 01 VALUE "6 : récapitulatif des pilotes".
      05 LINE 16 COL 01 VALUE "7 : facturation des vols aux pilotes".
      05 LINE 19 COL 01 VALUE "******************".   
      05 LINE 20 COL 01 PIC X(50) FROM ERREURS.
      05 LINE 21 COL 01 VALUE "ENTREZ UN CHOIX OU QUITTER (Q) :".
      05 LINE 22 COL 01 PIC X TO CHOIX.
      
PROCEDURE DIVISION.

DEBUT.

PERFORM AFFICHE-ACCUEIL.
PERFORM  MENU UNTIL QUITTER=0.

AFFICHE-ACCUEIL.
   ACCEPT WDATE FROM DATE
   DISPLAY SCREEN-ACCUEIL
   ACCEPT SCREEN-ACCUEIL.

MENU.
   EVALUATE CHOIX
   WHEN "0"
       CALL "LIST-AV-PIL"
   WHEN "1"
       CALL "DEPOT"
   WHEN "2"
       CALL "ENREGISTREMENT"
   WHEN "3"
       CALL "MAJ-PIL"
   WHEN "4"
       CALL "MAJ-AV"
   WHEN "5"
       CALL "RECAP-AV"
   WHEN "6"
       CALL "RECAP-PIL"
   WHEN "7"
       CALL "FACTURATION"
   WHEN "Q"
       MOVE 0 TO QUITTER
   WHEN OTHER
       MOVE "erreur dans votre choix" TO ERREURS.

FIN.
   STOP RUN.



