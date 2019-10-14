       IDENTIFICATION DIVISION.
       PROGRAM-ID. INDXREAD.
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
      * THIS PROGRAM READS AN INDEX FILE USING START LOGIC TO START 
      * AT A SPECIFIC KEY VALUE AND READS RECORDS TILL END OF FILE
      * FOR EACH RECORD, EPLOYEE NAME IS DISPLAYED.
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
         05 EMPID          PIC 9(05).
         05 EMPDEPT        PIC 9(03).
         05 EMPNAME        PIC X(20).
         05 EMPSALARY      PIC 9(06).
         05 EMPGRADE       PIC X(02).
         05 EMPDESIGNATION PIC X(20).
         05 FILLER         PIC X(34).

       WORKING-STORAGE SECTION.
       01 SWITCHES.
         05 WS-EMP-FILE-STATUS     PIC X(02) VALUE "00".
           88 EMP-STATUS-OK        VALUE "00".
         05 WS-EMP-FILE-END        PIC X(01) VALUE "N".
           88 EMP-FILE-END         VALUE "Y".
       PROCEDURE DIVISION.
       MAINLINE.
           PERFORM 1000-INIT THRU 1000-EXIT.
           PERFORM 2000-READ-FILE THRU 2000-EXIT.
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

       2000-READ-FILE.
           INITIALIZE EMPREC.

           MOVE 2 TO EMPID.
           START EMPFILE KEY >= EMPID
               INVALID KEY
                   PERFORM 2200-INVALID-KEY THRU 2200-EXIT.
           MOVE "N" TO WS-EMP-FILE-END.
           PERFORM 2100-READ-EMP-FILE THRU 2100-EXIT until
                   EMP-FILE-END.
       2000-EXIT.
           EXIT.

       2100-READ-EMP-FILE.
           READ EMPFILE NEXT
               AT end
                   DISPLAY "END OF FILE REACHED"
                   MOVE "Y" TO WS-EMP-FILE-END
                   GO TO 2200-EXIT.

           IF NOT EMP-STATUS-OK
               DISPLAY "ERROR READING EMFILE"
               DISPLAY "FILE STATUS : " WS-EMP-FILE-STATUS
               STOP RUN
           END-IF.

           DISPLAY "EMP-NAME: " EMPNAME.
       2100-EXIT.
           EXIT.

       2200-INVALID-KEY.
           DISPLAY "ERROR STARTING FILE"
           DISPLAY "FILE STATUS : " WS-EMP-FILE-STATUS
           STOP RUN.
       2200-EXIT.
           exit.

       9999-CLEANUP.
           CLOSE EMPFILE.
           DISPLAY "END OF PROCESSING".
       9999-EXIT.
           EXIT.