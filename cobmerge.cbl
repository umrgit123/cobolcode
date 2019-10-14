      *************************************************
      *This program demonstrates cobol internal merge.
      *merges two input files based on a key.
      *
      ***************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. cobmerge.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *
       SELECT IN-FILE-01      ASSIGN TO "mergein1.DAT"
                   organization is line sequential.
       SELECT IN-FILE-02      ASSIGN TO "mergein2.DAT"
                   organization is line sequential.
       SELECT OUT-FILE         ASSIGN TO "mergedout.DAT".
       SELECT WORK-FILE        ASSIGN TO "mergework.DAT".
      *
       DATA DIVISION.
       FILE SECTION.
      *
       FD IN-FILE-01.
       01 IN-REC-01.
         05 IN01-EMP-ID        PIC 9(5).
         05 IN01-EMP-NAME      PIC X(20).
      *
       FD IN-FILE-02.
       01 IN-REC-02.
         05 IN02-EMP-ID        PIC 9(5).
         05 IN02-EMP-NAME      PIC X(20).
      *
       FD OUT-FILE.
       01 OUT-REC.
         05 OUT-EMP-ID PIC 9(5).
         05 OUT-EMP-NAME PIC X(20).
      *
       SD WORK-FILE.
       01 SORT-REC.
         05 SORT-EMP-ID PIC 9(5).
         05 SORT-EMP-NAME PIC X(20).
      *
       PROCEDURE DIVISION.
           MERGE WORK-FILE
           ON ASCENDING KEY SORT-EMP-ID
             USING IN-FILE-01 IN-FILE-02 GIVING OUT-FILE.
           DISPLAY 'END PROCESSING'.
           STOP RUN.