      ********************************************************
      * Program to show use of arrays and subscripts
      * A 3 x 2 array is used as an example.You can modify to add
      * more levels if needed.
      *********************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SUBSCRPT.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-TV-TABLE.
         05 WS-TV OCCURS 3 TIMES.
           10 WS-TV-SIZE PIC 9(02).
           10 WS-TV-DETAILS.
              15 WS-TV-COST   OCCURS 2 TIMES.
                 20 WS-TV-MAKE  PIC X(7).
                 20 WS-TV-PRICE PIC 9(3).

       PROCEDURE DIVISION.
           MOVE 48 TO WS-TV-SIZE(1).
           MOVE 'SONY   800TOSHIBA650' TO WS-TV-DETAILS(1).
           MOVE 56 TO WS-TV-SIZE(2).
           MOVE 'SONY   900TOSHIBA750' TO WS-TV-DETAILS(2).
           MOVE 64 TO WS-TV-SIZE(3).
           MOVE 'SONY   999TOSHIBA850' TO WS-TV-DETAILS(3).

           DISPLAY WS-TV-SIZE(1) "INCHES  MAKE : " WS-TV-MAKE(1, 1)
                       " PRICE  :  " WS-TV-PRICE(1,1).
           DISPLAY WS-TV-SIZE(2) "INCHES  MAKE : " WS-TV-MAKE(2,2) 
                       " PRICE  :  " WS-TV-PRICE(2, 2).

           STOP RUN.