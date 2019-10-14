      *******************************************************************************
      *Program to show cursor processing. rows are fetched from employee table using a cursor and
      *data displayed on screen. database: MYSQL
      *You have to setup an ADO.NET connection string to connect to the database
      *To setup connection string: start -> micro focus visualcobol -> ADO.NET connection editor
      *I have named it UMRCONNECT. you can use whatever name suits your application
      *you need to include the statemet $SET SQL(DBMAN=ADO) at the top of the program
      *******************************************************************************
      $SET SQL(DBMAN=ADO)
       program-id. EMPLIST.

       data division.
       working-storage section.

       01 temp-enter pic x(01) value " ".

      *  SQL Communications Area. 

           EXEC SQL INCLUDE SQLCA END-EXEC.

      *  Declare host variables

           EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 empid pic x(5).
       01 fname pic x(40).
       01 lname pic x(20).
       01 deptid pic x(20).
           EXEC SQL END DECLARE SECTION END-EXEC.
      *
       procedure division.
       1000-main-para.
           perform 2000-init-routine thru 2000-exit.
           perform 3000-list-employees thru 3000-exit.
           perform 9999-cleanup thru 9999-exit.
           stop run.
       1000-exit.
           exit.

       2000-init-routine.
           EXEC SQL CONNECT to UMRCONNECT
           END-EXEC.
           if sqlcode not = 0
               display "Error: not connected"
               display sqlcode
               display sqlerrmc
               stop run
           end-if.
       2000-exit.
           exit.

       3000-list-employees.
           EXEC SQL
               DECLARE emp-curs CURSOR FOR
                   select EmpId, Fname, Lname, DeptId from employee
                   order by EmpId
           END-EXEC

           EXEC SQL OPEN emp-curs END-EXEC

           if sqlcode not = 0
               display sqlcode
               display sqlerrmc
           else
               perform until exit

                   EXEC SQL
                       FETCH emp-curs INTO
                           :empid, :fname, :lname, :deptid
                   END-EXEC

                   if sqlcode = 100
                       display "End of results"
                       exit perform
                   end-if

                   if sqlcode not = 0
                       display sqlcode
                       display sqlerrmc
                       exit perform
                   else
                       display "EMPID : " empid
                         "FNAME : " fname
                         "LNAME : " lname
                         "DEPTID : " deptid
                       accept temp-enter
                   end-if

               end-perform

           end-if

           EXEC SQL CLOSE emp-curs END-EXEC.
       3000-exit.
           exit.

       9999-cleanup.
           EXEC SQL
               DISCONNECT UMRCONNECT
           END-EXEC.
       9999-exit.
           exit.
