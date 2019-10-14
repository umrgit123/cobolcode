// Thanks to IonicaBizau who has developed the node cobol bridge
// You need to install GNU Cobol and then "npm i cobol" for this to work
// Dependencies
var Cobol = require("cobol");

// Execute some COBOL snippets
Cobol(function () { /*
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-USER-NAME  PIC X(20).
       PROCEDURE DIVISION.
       PROGRAM-BEGIN.
           DISPLAY "Hello world".
           display "It works!!!!".
       PROGRAM-DONE.
           STOP RUN.
*/ }, function (err, data) {
    console.log(err || data);
});
