      *********************************************************************
      * SIMPLE PROGRAM TO INSERT A RECORD INTO EMPLOYEE TABLE
      * THIS CAN BE EASILY MODIFIED TO ADD UPDATE AND DELETE FUNCTIONS
      **********************************************************************
      $SET SQL(DBMAN=ADO)
       PROGRAM-ID. EMPINSERT.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *  INCLUDE THE SQL COMMUNICATIONS AREA. THIS INCLUDES THE
      *  DEFINITIONS OF SQLCODE, ETC
           EXEC SQL INCLUDE SQLCA END-EXEC.

       PROCEDURE DIVISION.
       MAIN-PARA.
           PERFORM CONNECT-DATABASE THRU CONNECT-DATABASE-EXIT.
           PERFORM INSERT-EMP THRU INSERT-EMP-EXIT.
           PERFORM CLEAN-UP.
           STOP RUN.

       CONNECT-DATABASE.
           EXEC SQL CONNECT TO UMRCONNECT
           END-EXEC.
           IF SQLCODE NOT = 0
               DISPLAY "ERROR: NOT CONNECTED"
               DISPLAY SQLCODE
               DISPLAY SQLERRMC
               STOP RUN
           END-IF.
       CONNECT-DATABASE-EXIT.
           EXIT.

       INSERT-EMP.
           EXEC SQL
               INSERT INTO EMPLOYEE (FNAME, LNAME, DEPTID)
               VALUES ("ABC", "DEF", 005)
           END-EXEC
           IF SQLCODE NOT = 0
               DISPLAY SQLCODE
               DISPLAY SQLERRMC
               STOP RUN
           END-IF.
           DISPLAY "INSERT SUCCESSFUL".
       INSERT-EMP-EXIT.
           EXIT.

       CLEAN-UP.
           EXEC SQL
               DISCONNECT UMRCONNECT
           END-EXEC.

