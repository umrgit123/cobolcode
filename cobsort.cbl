      *************************************************
      *This program demonstrates cobol internal sort.
      *This can be modified to add input and output processing
      *if reqired.
      *
      *For simple sorts on maiframe it is recommeded to use
      *JCL sort rather than sorting via program.
      *
      ***************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. COBSORT.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT IN-FILE      ASSIGN TO "unsorted.DAT"
           organization is line sequential.
       SELECT OUT-FILE     ASSIGN TO "sortedout.DAT".
       SELECT WORK-FILE    ASSIGN TO "workfile.DAT".
       DATA DIVISION.
       FILE SECTION.
       FD IN-FILE.
       01 IN-REC.
          05 IN-EMP-ID         PIC 9(5).
          05 IN-EMP-NAME       PIC X(20).
       FD OUT-FILE.
       01 OUT-REC.
          05 OUT-EMP-ID        PIC 9(5).
          05 OUT-EMP-NAME      PIC X(20).
       SD WORK-FILE.
       01 SORT-REC.
          05 SORT-EMP-ID       PIC 9(5).
          05 SORT-EMP-NAME     PIC X(20).
       PROCEDURE DIVISION.
           SORT WORK-FILE
           ON ASCENDING KEY SORT-EMP-ID
             USING IN-FILE GIVING OUT-FILE.
           DISPLAY 'END PROCESSING'.
           STOP RUN.