%%% Coursework 1 2020
%%% Author: Myriam Kapon - dai17093

%%%EXERCISE 1

%%%exclude_range/4
exclude_range(_,_,[],[]).
exclude_range(Low,High,[X|Tail],NewList):-
    X >= Low,X =< High,!,
    exclude_range(Low,High,Tail,NewList).

exclude_range(Low,High,[X|Tail],[X|NewList]):-
    exclude_range(Low,High,Tail,NewList).

%%%diazeu3h san lunion

%%%EXERCISE 2
double(X,Y):-Y is X * 2.
inc(X,Y):-Y is X + 1.
square(X,Y):- Y is X*X.

%%%math_match/3 A
math_match([_],_,[]).
math_match([X1,X2|Rest], C, [(X1,X2)|Solution]):-
    Predicate =.. [C,X1,X2],
    call(Predicate),!,
    math_match([X2|Rest],C,Solution).

math_match([_,X2|Rest], C, Solution):-
    math_match([X2|Rest],C,Solution).

%%%math_match_alt/3 B
 math_match_alt(List, C, Solution):-
     Predicate =.. [C,X1,X2],
     setof((X1,X2),(pair(X1,X2,List),call(Predicate)),Solution).

%%%pair/3
%%% Succeeds when X,Y appear next to
%%% each other in a list
pair(X,Y,List):-
    append(L2,[Y|_], List),
    append(_,[X],L2). %L2's Last element is X

%%%EXERCISE 3
a_block(b1,2,4).
a_block(b2,1,3).
a_block(b3,3,3).
a_block(b4,1,2).
a_block(b5,4,1).
a_block(b6,2,1).
a_block(b7,5,3).
a_block(b8,5,2).
a_block(b9,4,4).
a_block(b10,2,3).

%%%stack_blocks/3
stack_blocks([X,Y,Z],[X2,Y2,Z2],H):-
    stack(X,Y,Z,H),
    stack(X2,Y2,Z2,H),
    different([X,Y,Z],[X2,Y2,Z2]).

%%%top/2
%%%Succeeds when B2 is on top of B1
top(B1,B2):-
    a_block(B1,_,W1),
    a_block(B2,_,W2),
    W2 =< W1.

%%%stack/4
%%%Succeeds if X,Y,Z is a stack and returns the Height
stack(X,Y,Z, H):-
    top(X,Y),
    top(Y,Z),
    a_block(X,H1,_),
    a_block(Y,H2,_),
    Y \= X,
    a_block(Z,H3,_),
    Z \= X,
    Z \= Y,
    H is H1+H2+H3.

%%%different/2
%%%Succeeds when the 2 Lists don't have any common elements
different(List1,List2):-
    findall(X, (member(X, List1),member(X,List2)), []).

%find_min/3
find_min([X],X,0).
find_min([X,Y|Tail],Min,Counter):-
    X=<Y,!,
    find_min([X|Tail],Min,CounterSoFar),
    Counter is CounterSoFar+1.

find_min([X,Y|Tail],Min,Counter):-
    Y=<X,
    find_min([Y|Tail],Min,CounterSoFar),
    Counter is CounterSoFar+1.

%%%find_lowest_stack/4
find_lowest_stack(StaA, StaB, Min, Sols):-
    findall(H,stack(_X,_Y,_Z,H),Heights),
    find_min(Heights,Min,Sols), %test
    stack_blocks(StaA,StaB,Min).
