       IDENTIFICATION DIVISION.
       PROGRAM-ID. INDXDEUP.
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
      * THIS PROGRAM UPDATES ONE RECORD AND DELETES ONE RECORD
      * FROM INDEX FILE
      * 
      * FILE CREATED IN INDXFILE PROGRAM IS INPUT TO THIS PROGRAM
      * RUN INDXFILE PROGRAM FIRST
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
        SELECT EMPFILE ASSIGN "EMPFIL"
                       ACCESS DYNAMIC
                       ORGANIZATION INDEXED
                       STATUS WS-EMP-FILE-STATUS
                       RECORD KEY EMPID .
       DATA DIVISION.
       FILE SECTION.

       FD EMPFILE
       RECORD 80.
       01 EMPREC.
          05 EMPID             PIC 9(05).
          05 EMPDEPT           PIC 9(03).
          05 EMPNAME           PIC X(20).
          05 EMPSALARY         PIC 9(06).
          05 EMPGRADE          PIC X(02).
          05 EMPDESIGNATION    PIC X(20).
          05 FILLER            PIC X(34).

       WORKING-STORAGE SECTION.
      *
       01 SWITCHES.
          05 WS-EMP-FILE-STATUS    PIC X(02) VALUE "00".
             88 EMP-STATUS-OK      VALUE "00".
      *
       PROCEDURE DIVISION.
       MAINLINE.
           PERFORM 1000-INIT THRU 1000-EXIT.
           PERFORM 2000-UPDATE-REC THRU 2000-EXIT.
           PERFORM 3000-DELETE-REC THRU 3000-EXIT.
           PERFORM 9999-CLEANUP THRU 9999-EXIT.
           STOP RUN.

       1000-INIT.
           OPEN I-O EMPFILE.
      *
      *
           IF EMP-STATUS-OK
               continue
           ELSE
               DISPLAY "ERROR OPENING EMFILE"
               DISPLAY "FILE STATUS : " WS-EMP-FILE-STATUS
               STOP RUN
           END-IF.
       1000-EXIT.
           EXIT.

       2000-UPDATE-REC.
           MOVE 2 TO EMPID.
           READ EMPFILE INVALID KEY
                  PERFORM 9000-INVALID-KEY THRU 9000-EXIT.
           MOVE "UPDATE EMP 02" TO EMPNAME
           REWRITE EMPREC INVALID key
                   PERFORM 9000-INVALID-KEY THRU 9000-EXIT.
           DISPLAY "UPDATE SUCCESSFUL".
       2000-EXIT.
           EXIT.

       3000-DELETE-REC.
           MOVE 3 TO EMPID.
           DELETE EMPFILE
               INVALID KEY
                   PERFORM 9000-INVALID-KEY THRU 9000-EXIT.
           DISPLAY "DELETE SUCCESSFUL".
       3000-EXIT.
           EXIT.

       
       9000-INVALID-KEY.
           DISPLAY "FILE ERROR"
           DISPLAY "FILE STATUS : " WS-EMP-FILE-STATUS
           STOP RUN.
       9000-EXIT.
           exit.

       9999-CLEANUP.
           CLOSE EMPFILE.
           DISPLAY "END OF PROCESSING".
       9999-EXIT.
           EXIT.