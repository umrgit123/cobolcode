      *********************************************************************
      * THIS PROGRAM CONTAINS SOME SQL QUERIES TO DEMONSTRATE STRING HANDLING, DATES ETC
      * MORE FUNCTIONS WILL BE ADDED IN FUTURE
      *********************************************************************
      $SET SQL(DBMAN=ADO)
       PROGRAM-ID. IGDBSQLS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *  INCLUDE THE SQL COMMUNICATIONS AREA. THIS INCLUDES THE
      *  DEFINITIONS OF SQLCODE, ETC
           EXEC SQL INCLUDE SQLCA END-EXEC.

           EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 H-DAYOFWEEK          PIC X(20).
       01 H-DAYNAME            PIC X(20).
       01 H-COUNT              PIC 9(05).
       01 H-TEMP-STRING        PIC X(20).
       01 H-TEMP-NUM           PIC 9(05).
           EXEC SQL END DECLARE SECTION END-EXEC.


       PROCEDURE DIVISION.
       MAIN-PARA.
           PERFORM 1000-CONNECT-DATABASE THRU 1000-EXIT.
           PERFORM 2000-RUNSQLS THRU 2000-EXIT.
           PERFORM 9000-CLEAN-UP.
           STOP RUN.

       1000-CONNECT-DATABASE.
           EXEC SQL CONNECT TO UMRCONNECTIG
           END-EXEC.
           IF SQLCODE NOT = 0
               DISPLAY "ERROR: NOT CONNECTED"
               DISPLAY SQLCODE
               DISPLAY SQLERRMC
               STOP RUN
           END-IF.
       1000-EXIT.
           EXIT.

       2000-RUNSQLS.

      * WHAT DAY OF WEEK DO MOST USERS REGISTER ON
           EXEC SQL
               SELECT DAYOFWEEK(CREATED_AT), DAYNAME(CREATED_AT), COUNT(*)
                   INTO :H-DAYOFWEEK, :H-DAYNAME, :H-COUNT
                   FROM UMR_IG_USERS
                   GROUP BY DAYOFWEEK(CREATED_AT)
                   ORDER BY COUNT(*) DESC
           END-EXEC.
           DISPLAY "RESULT : " H-DAYOFWEEK " - " H-DAYNAME " - " H-COUNT.

      * THIS QUERY WILL REPLACE ELL WITH KK
           EXEC SQL
               SELECT REPLACE("HELLO WORLD", "ELL", "KK")
               INTO :H-TEMP-STRING
           END-EXEC.
           DISPLAY "REPLACE RESULT : " H-TEMP-STRING


      * THIS QUERY WILL REVERSE STRING
           EXEC SQL
               SELECT REVERSE("JKLM")
               INTO :H-TEMP-STRING
           END-EXEC.
           DISPLAY "REVERSE RESULT : " H-TEMP-STRING.

      * GET LENGTH OF STRING
           EXEC SQL
               SELECT CHAR_LENGTH("abcde")
               INTO :H-TEMP-NUM
           END-EXEC.
           DISPLAY "CHAR LENGTH ABCDE RESULT : " H-TEMP-NUM.

      * CONVERT TO UPPERCASE
           EXEC SQL
               SELECT UPPER("abcde")
               INTO :H-TEMP-STRING
           END-EXEC.
           DISPLAY "RESULT UPPERCASE: " H-TEMP-STRING.

      * CONVERT TO LOWERCASE
           EXEC SQL
               SELECT LOWER("XYZ")
               INTO :H-TEMP-STRING
           END-EXEC.
           DISPLAY "RESULT LOWERCASE: " H-TEMP-STRING.
       2000-EXIT.
           EXIT.

       9000-CLEAN-UP.
           EXEC SQL
               DISCONNECT UMRCONNECTIG
           END-EXEC.
       9000-EXIT.
           EXIT.