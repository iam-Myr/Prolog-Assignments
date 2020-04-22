%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%lunion/3
lunion([],List,List).

lunion([X|Rest],List,IntList):-
    member(X,List), !, lunion(Rest,List,IntList).

lunion([X|Rest], List, [X|IntList]):-
    lunion(Rest,List,IntList).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%reduce/3
reduce(_,[X],X).
reduce(Operation,[X,Y|Tail],Result):-
    C =.. [Operation,X,Y,Result2],
    call(C),
    reduce(Operation,[Result2|Tail],Result).
