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
replace(X,Y,[X|T],[Y|T]).

replace(X,Y,[H|T],[H|T2]):-
    replace(X,Y, T, T2).
