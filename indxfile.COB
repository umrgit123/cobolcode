        IDENTIFICATION DIVISION.
        PROGRAM-ID. INDXFILE.
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
      * THIS PROGRAM CREATES AN INDEX FILE WITH THREE RECORDS.
      * RECORD DETAILS ARE HARDCODED. YOU CAN EASILY MODIFY THE
      * PROGRAM TO READ AN INPUT FILE AND WRITE TO EMPFILE.
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
        ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
        SELECT EMPFILE ASSIGN "EMPFIL"
                       ACCESS DYNAMIC
                       ORGANIZATION INDEXED
                       STATUS EMP-FILE-STATUS
                       RECORD KEY EMPID .
        DATA DIVISION.
        FILE SECTION.

        FD EMPFILE
        RECORD 80.
        01 EMPREC.
            05 EMPID           PIC 9(05).
            05 EMPDEPT         PIC 9(03).
            05 EMPNAME         PIC X(20).
            05 EMPSALARY       PIC 9(06).
            05 EMPGRADE        PIC X(02).
            05 EMPDESIGNATION  PIC X(20).
            05 FILLER          PIC X(34).

        WORKING-STORAGE SECTION.
        01 SWITCHES.
           05 EMP-FILE-STATUS PIC X(02) VALUE "00".
              88 EMP-STATUS-OK VALUE "00".
              88 EMP-FILE-NOT-FOUND VALUE "05".
        01 WRITE-COUNT        PIC 9(02) VALUE 0.
        PROCEDURE DIVISION.
        MAINLINE.
           PERFORM 1000-INIT THRU 1000-EXIT.
           PERFORM 2000-CREATE-FILE THRU 2000-EXIT.
           PERFORM 9999-CLEANUP THRU 9999-EXIT.
           STOP RUN.

       1000-INIT.
           OPEN OUTPUT EMPFILE.
      * IF FILE DOES NOT EXIST YOU WILL GET STATUS 05 WHICH IS OK
      * AS THE PROGRAM IS CREATING THE FILE.
           IF EMP-STATUS-OK
               continue
           ELSE
               DISPLAY "ERROR OPENING EMFILE"
               DISPLAY "FILE STATUS : " EMP-FILE-STATUS
               STOP RUN
           END-IF.
       1000-EXIT.
           EXIT.

       2000-CREATE-FILE.
           INITIALIZE EMPREC.

           MOVE 1              TO EMPID
           MOVE 001            TO EMPDEPT.
           MOVE "EMPLOYEE 01"  TO EMPNAME.
           MOVE 10000          TO EMPSALARY.
           MOVE "11"           TO EMPGRADE.
           MOVE "DEVELOPER"    TO EMPDESIGNATION.
           PERFORM 2100-WRITE-EMP-REC THRU 2100-EXIT.
           ADD 1 TO WRITE-COUNT.

           MOVE 2 TO EMPID
           MOVE 002 TO EMPDEPT.
           MOVE "EMPLOYEE 02" TO EMPNAME.
           MOVE 20000 TO EMPSALARY.
           MOVE "22" TO EMPGRADE.
           MOVE "SENIOR DEVELOPER" TO EMPDESIGNATION.
           PERFORM 2100-WRITE-EMP-REC THRU 2100-EXIT.
           ADD 1 TO WRITE-COUNT.

           MOVE 3 TO EMPID
           MOVE 003 TO EMPDEPT.
           MOVE "EMPLOYEE 01" TO EMPNAME.
           MOVE 30000 TO EMPSALARY.
           MOVE "33" TO EMPGRADE.
           MOVE "JUNIOR DEVELOPER" TO EMPDESIGNATION.
           PERFORM 2100-WRITE-EMP-REC THRU 2100-EXIT.
           ADD 1 TO WRITE-COUNT.
       2000-EXIT.
           EXIT.
           
       2100-WRITE-EMP-REC.
           WRITE EMPREC.
           IF NOT EMP-STATUS-OK
               DISPLAY "ERROR WRITING EMFILE"
               DISPLAY "FILE STATUS : " EMP-FILE-STATUS
               STOP RUN
           END-IF.
       2100-EXIT.
           EXIT.

       9999-CLEANUP.
           CLOSE EMPFILE.
           DISPLAY "END OF PROCESSING".
           DISPLAY "NO OF RECORDS WRITTEN: " WRITE-COUNT.
       9999-EXIT.
           EXIT.