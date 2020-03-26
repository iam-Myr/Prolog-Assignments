%%%%%%%%%%%%%%%%%%%%%%%     ASSIGNMENT 6
%%%sum_even/2
%%%sum_even([H|T], Sum)
%%%Returns the sum of even numbers in a list
sum_even([],0).

sum_even([H|T], Sum):-
    0 is H mod 2,
	sum_even(T, SumT),
	Sum is H + SumT.

sum_even([H|T], Sum):-
	1 is H mod 2,
	sum_even(T, Sum).

%%%%%%%%%%%%%%%%%%%%%%%     ASSIGNMENT 7
%%%replace/4
%%%replace(X,Y,List,ResultList)
replace(X,Y,[X|Tail],[Y|Tail]).

replace(X,Y,[H|Tail],[H|Answer]):-
    replace(X,Y, Tail, Answer).
