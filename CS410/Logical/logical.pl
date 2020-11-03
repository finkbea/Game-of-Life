%Adicus Finkbeiner
%CS410 Logical Programming

main :-
    open('rand.txt', read, FD), 
    setRows(FD, 0),
    close(FD),
    printRows(0).

%sets up the rows, 
setRows(FD, 100) :- !.
setRows(FD, Row) :- 
    setCols(FD, Row, 0),
    NextR is Row + 1,
    setRows(FD, NextR).

%sets up the columns, reads in ints from the rand.txt file
setCols(FD, Row, 100) :- !.
setCols(FD, Row, Col) :-
    read_integer(FD, Int),
    (Int == 1 -> asserta(voted(Row, Col)) ; !),
    NextC is Col + 1,
    setCols(FD, Row, NextC).

%set get each neighbors value and check if they are greater than 4
vote(Row, Col) :-
    Up is Row-1, Down is Row+1, Left is Col-1, Right is Col+1,
    (voted(Up, Left) -> Int1 is 1 ; Int1 is 0), 
    (voted(Up, Col) -> Int2 is 1 ; Int2 is 0),
    (voted(Up, Right) -> Int3 is 1 ; Int3 is 0),
    (voted(Row, Left) -> Int4 is 1 ; Int4 is 0),
    (voted(Row, Col) -> Int5 is 1 ; Int5 is 0),
    (voted(Row, Right) -> Int6 is 1 ; Int6 is 0),
    (voted(Down, Left) -> Int7 is 1 ; Int7 is 0),
    (voted(Down, Col) -> Int8 is 1 ; Int8 is 0),
    (voted(Down, Right) -> Int9 is 1 ; Int9 is 0),
    Neighbors is Int1+Int2+Int3+Int4+Int5+Int6+Int7+Int8+Int9,
    Neighbors > 4.

%prints the matrix rows, same logic as setting them, sets newlines between rows
printRows(100) :- !.
printRows(Row) :-
    printCols(Row, 0),
    NextR is Row + 1,
    nl,
    printRows(NextR).

%prints the matrix columns, does the actual printing
printCols(Row, 100) :- !.
printCols(Row, Col) :-
    (vote(Row, Col) -> write(1) ; write(0)),
    NextC is Col + 1, 
    printCols(Row, NextC).

