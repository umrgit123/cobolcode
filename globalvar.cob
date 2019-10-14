      *****************************************************************
      * Program to show usage of variables with GLOBAL clause and
      * also usage of IS COMMON in program id.
      * Variables defined as GLOBAL can be accessed in main program as
      * well as the sub programs without being passed via linkage.
      * Main program: Main
      * Sub program 1: CalculateArea
      * Sub program 2: DisplayProgname
      *****************************************************************
      *
      * Program: Main
      *
        IDENTIFICATION DIVISION.
        PROGRAM-ID. Main.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 Globalvar       PIC X(50) IS GLOBAL.
        01 rec-length      PIC 9(4) IS GLOBAL value 20.
        01 rec-width       PIC 9(4) IS GLOBAL value 12.
        PROCEDURE DIVISION.
        Begin.
            CALL "CalculateArea"
            MOVE "In Main Program" TO Globalvar
            CALL "DisplayProgname"
            STOP RUN.
      *
      * Program: CalculateArea
      *
        IDENTIFICATION DIVISION.
        PROGRAM-ID. CalculateArea.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 rec-area PIC 9(5) value 0.
        PROCEDURE DIVISION.
        Begin.
           MOVE "In CalculateArea" TO Globalvar
           CALL "DisplayProgname"
           compute rec-area = rec-length * rec-width.
           string " Area of rectangle is : " rec-area
             into Globalvar.
           CALL "DisplayProgname".

           EXIT PROGRAM.
        END PROGRAM CalculateArea.
      *
      * Program: DisplayProgname
      *
        IDENTIFICATION DIVISION.
        PROGRAM-ID. DisplayProgname IS COMMON PROGRAM.
        PROCEDURE DIVISION.
        Begin.
            DISPLAY Globalvar.
            ACCEPT Globalvar.
            EXIT PROGRAM.
        END PROGRAM DisplayProgname.
      *
      * Main program ends below.
        END PROGRAM Main.
