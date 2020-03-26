%%%symmetric/1
%%%symmetric[List1]
symmetric(L):-
    append(L1, L1, L).

%%%end_sublist/2
end_sublist(L1,L2):-
    append(_,L1,L2).

%%%last_element/2
last_element(L,X):-
    append(_,[X],L).

sublist(L1,L2):-
    append(Ltemp,_,L2),
    append(_,L1,Ltemp).

%%%twice_sublist/2
twice_sublist(Sub,L):-
    append(L1, L2, L),
    sublist(Sub,L1),
    sublist(Sub,L2).

%%%rotate_left/3
rotate_left(Pos,List,RotList):-
    append(L1,L2,List),
    length(L1,Pos),
    append(L2,L1,RotList).

%%%common_suffix/4
common_suffix(List1,List2,Suffix,Pos):-
    append(_,Suffix,List1),
    append(_,Suffix,List2),
    length(Suffix,Pos).
