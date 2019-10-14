      * Demonstrates the use of INITIAL and CANCEL PROGRAM instructions
      *
      * Program A calls program B. When program B finishes and returns
      * control to program A, working storage of program B remains in
      * memory. When program B is called again, working storage of
      * program B will be different from the first time it is called.
      * To initialize working storage eveytime program B is called, it
      * needs to have INITIAL clause in program ID section.
      *
      * In the example below, program DoubleRecur does not have INITIAL
      * clause while program DoubleNoRecur has Initial clause. Results
      * from DoubleNoRecur will always be the same if called with same
      * parameters while result from DouleRecur will be diffent with
      * each call. To initialize working storage of program that does
      * not have INITIAL clause, you can use CANCEL program statement
      *
      * All these are demonstrated using a simple program below.
      *
      *************************************************************
        IDENTIFICATION DIVISION.
        PROGRAM-ID. MainProg.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 inputnum      PIC 99 VALUE ZERO.
           88 quitprogram VALUE ZERO.
        screen section.
       01 input-screen.
           05 line 2 column 2 value 
           "Enter a number between 1 and 99".
           05 line 3 column 2 value " Enter 0 to quit".
           05 scr-input line 3 column 20 pic 9(02) using inputnum.
        PROCEDURE DIVISION.
        Begin.
          display input-screen.
          accept input-screen.

          If not quitprogram
              PERFORM 3 times
                 Display "Result without cancelling program"
                 CALL "DoubleRecur"    USING BY CONTENT inputnum
                 CALL "DoubleNoRecur"  USING BY CONTENT inputnum
              END-PERFORM

              PERFORM 3 times
                 Display "Result with cancelling program"
                 cancel "DoubleRecur"
                 CALL "DoubleRecur"    USING BY CONTENT inputnum
                 CALL "DoubleNoRecur"  USING BY CONTENT inputnum
              END-PERFORM
          ELSE
             STOP RUN
          END-IF.

        IDENTIFICATION DIVISION.
        PROGRAM-ID. DoubleRecur.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 RunningTotal   PIC 9(5) VALUE ZERO.
        LINKAGE SECTION.
        01 ParamValue     PIC 99.
        PROCEDURE DIVISION USING ParamValue.
        Begin.
          ADD ParamValue TO RunningTotal.
          DISPLAY "Total from DoubleRecur   = " WITH NO ADVANCING
          CALL "DisplayTotal" USING BY CONTENT RunningTotal
          EXIT PROGRAM.
        END PROGRAM DoubleRecur.


        IDENTIFICATION DIVISION.
        PROGRAM-ID. DoubleNoRecur IS INITIAL.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 RunningTotal PIC 9(5) VALUE ZERO.
        LINKAGE SECTION.
        01 ParamValue PIC 99.
        PROCEDURE DIVISION USING ParamValue.
        Begin.
          ADD ParamValue TO RunningTotal.
          DISPLAY "Total from DoubleNoRecur " WITH NO ADVANCING
          CALL "DisplayTotal" USING BY CONTENT RunningTotal
          EXIT PROGRAM.
        END PROGRAM DoubleNoRecur.

        IDENTIFICATION DIVISION.
        PROGRAM-ID. DisplayTotal IS COMMON INITIAL PROGRAM.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 PrnTotal  PIC ZZ,ZZ9.
        LINKAGE SECTION.
        01 Total     PIC 9(5).
        PROCEDURE DIVISION USING Total.
        Begin.
          MOVE Total TO PrnTotal.
          DISPLAY PrnTotal.
          EXIT PROGRAM.
        END PROGRAM DisplayTotal.
        END PROGRAM MainProg.
