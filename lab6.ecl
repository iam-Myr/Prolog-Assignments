%%%set_diff_f/3
set_diff_f(L1,L2,L):-
    findall(X, (member(X,L1), not(member(X,L2))),L).

%%%map_f/3
map_f(Op,List,Res):-
    findall(Y, map_aux(Op,List,Y),Res).

map_aux(Op,List,Y):-
    member(X,List),
    Predicate =..[Op,X,Y],
    call( Predicate ).

%%%%%%%%%%EXC 7
%%%%
:-op(450,yfx,and).
:-op(500,yfx,or).
:-op(400,fy,--).
:-op(600,yfx,==>).
:-op(500,yfx,xor).
:-op(500,yfx,nor).
:-op(450,yfx,nand).


Arg1 and Arg2 :- Arg1, Arg2.
Arg1 or _Arg2 :- Arg1.
_Arg1 or Arg2 :- Arg2.
--Arg1 :- not(Arg1).

Arg1 ==> Arg2 :- --Arg1 or Arg2.
Arg1 xor Arg2 :- Arg1, --Arg2.
Arg1 xor Arg2 :- Arg2, --Arg1.

Arg1 nor Arg2 :- --(Arg1 or Arg2).
Arg1 nand Arg2 :- --(Arg1 and Arg2).

t.
f:-!,fail.

%%%%%%%%%%EXC 4
%%%%proper_set_s/1
proper_set_s([]).
proper_set_s(List):-
    setof( X, member(X, List), List).

%%%%%%%%%%EXC 8
%%%%model/1
model(Term):-
	term_variables(Term,[]),
	call(Term).

model(Term):-
    term_variables(Term,[Var|_Rest]),
    member(Var,[t,f]),
    model(Term).

%%%theory/1
theory([Exp]):-
    model(Exp).

theory([Exp|Rest]):-
    model(Exp),
    theory(Rest).

%%%Part c:
%%%?- setof(X, theory([Y, Y ==> X or Y, X or Y ==> Y]), Sol).
