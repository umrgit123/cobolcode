      *********************************************************
      *THIS IS A SIMPLE PROGRAM TO DEMONSTRATE COBOL'S REPORT WRITER
      *FEATURE. 
      *
      *PROGRAM PRINTS OUT DETAILS OF FOUR EMPLOYEES. TWO EMPLOYEES
      *OF ONE DEPT AND TWO OF A DIFFERENT DEPT. DEPARTMENT WISE TOTALS
      *ARE PRINTED AND AT THE END A GRAND TOTAL LINE IS PRINTED.
      *
      *EMPLOYEE DETAILS ARE HARD CODED IN THE PROGRAM. PROGRAM CAN BE 
      *MODIFIED TO READ FROM A DATABASE OR FILE AS REQUIRED.
      *
      *************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAINPROG.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT PRINT-FILE ASSIGN TO "EMPREPORT.DAT"
       ORGANIZATION IS LINE SEQUENTIAL
       FILE STATUS IS PRT-FILE-STATUS.

       DATA DIVISION.
       FILE SECTION.
       FD    PRINT-FILE
           REPORT IS EMP-REPORT.

       WORKING-STORAGE SECTION.
       01 INDICATORS.
          05 PRT-FILE-STATUS PIC X(02) VALUE SPACES.

       01 EMP-RECORD.
         05 EMP-ID PIC 9(04).
         05 EMP-NAME PIC X(20).
         05 EMP-DEPT PIC 99.
         05 EMP-SALARY PIC 9(6)V99.
       REPORT SECTION.
       RD EMP-REPORT
          CONTROLS ARE EMP-DEPT
          PAGE LIMIT 40 LINES
          FIRST DETAIL 5
       	  LAST DETAIL 35
          FOOTING 38.
       01 TYPE IS PAGE HEADING.
          05 LINE 1.
             10 COLUMN 61 PIC X(4) VALUE 'PAGE'.
             10 COLUMN 66 PIC ZZZ9 SOURCE PAGE-COUNTER.
          05  LINE PLUS 1.
             10 COLUMN 26 PIC X(23) VALUE 'EMPLOYEE LIST'.
          05 LINE PLUS 1.
             10 COLUMN 3 PIC X(23) VALUE 'EMPID'.
             10 COLUMN 15 PIC X(20) VALUE 'EMP NAME'.
             10 COLUMN 38 PIC X(04) VALUE 'DEPT'.
             10 COLUMN 49 PIC X(06) VALUE 'SALARY'.
       01 REPORT-LINE TYPE DETAIL LINE PLUS 1.
          05 COLUMN 4      PIC 9(4) SOURCE    EMP-ID.
          05 COLUMN 15    PIC X(20) SOURCE EMP-NAME.
          05 COLUMN 40    PIC 99 SOURCE EMP-DEPT.
          05 COLUMN 46    PIC ZZZZ99.99 SOURCE EMP-SALARY.
       01 TYPE IS CONTROL FOOTING EMP-DEPT LINE PLUS 2.
          05 COLUMN 50 PIC X(20) VALUE "DEPARTMENT TOTAL : ".
          05 DEPT-TOTAL COLUMN 75 PIC ZZZ,ZZZ.99 SUM EMP-SALARY.
       01 TYPE IS CONTROL FOOTING FINAL LINE PLUS 2.
          05 COLUMN 50 PIC X(20) VALUE "G R A N D   TOTAL : ".
          05 FINAL-TOTAL COLUMN 75 PIC ZZZ,ZZZ.99
                                      SUM DEPT-TOTAL.
       PROCEDURE DIVISION.
       1000-CREATE-REPORTS.
           OPEN OUTPUT PRINT-FILE.

           IF PRT-FILE-STATUS NOT EQUAL '00'
               DISPLAY "BAD FILE STATUS : " PRT-FILE-STATUS
               STOP RUN.

           INITIATE EMP-REPORT.
           PERFORM 2000-GENERATE-REPORT THRU 2000-EXIT.
           STOP RUN.

       2000-GENERATE-REPORT.
           OPEN OUTPUT PRINT-FILE.
           INITIATE EMP-REPORT
           PERFORM
               MOVE 1 TO EMP-ID
               MOVE "JOHN" TO EMP-NAME
               MOVE 76 TO EMP-DEPT
               MOVE 10000.11 TO EMP-SALARY
               GENERATE REPORT-LINE

               MOVE 2 TO EMP-ID
               MOVE "KEVIN" TO EMP-NAME
               MOVE 76 TO EMP-DEPT
               MOVE 50000.35 TO EMP-SALARY
               GENERATE REPORT-LINE

               MOVE 3 TO EMP-ID
               MOVE "TRACY" TO EMP-NAME
               MOVE 87 TO EMP-DEPT
               MOVE 20000.45 TO EMP-SALARY
               GENERATE REPORT-LINE

               MOVE 4 TO EMP-ID
               MOVE "DENNIS" TO EMP-NAME
               MOVE 87 TO EMP-DEPT
               MOVE 9800.00 TO EMP-SALARY
               GENERATE REPORT-LINE
           END-PERFORM
           TERMINATE EMP-REPORT.
           CLOSE PRINT-FILE.
       2000-EXIT.
           EXIT.
           