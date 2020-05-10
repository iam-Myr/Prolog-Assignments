%%%%%EXC 1
%%%transitions/3
transitions(s1,s2,10).
transitions(s1,s3,20).
transitions(s1,s6,50).
transitions(s2,s3,10).
transitions(s2,s4,20).
transitions(s3,s4,10).
transitions(s3,s5,20).
transitions(s1,s2,10).
transitions(s4,s5,10).
transitions(s4,s6,20).
transitions(s5,s6,10).

%%%coins_to_insert/3
coins_to_insert(Node, Node, []).

coins_to_insert(Node, FNode,  [NextCoins|Coins]):-
    transitions(Node, Next,NextCoins),
    coins_to_insert(Next, FNode, Coins).

%setof(Coins,coins_to_insert(s1,s6,Coins),List)

%%%%EXC2
%%%connection/3
connect(i1,i2,b1).
connect(rb1,i1,b2).
connect(rb1,i1,b3).
connect(rb1,i2,b4).
connect(rb2,i1,b5).
connect(rb2,i1,b6).
connect(rb2,i2,b7).

connection(Loc1,Loc2,Bridge):-
    connect(Loc1,Loc2,Bridge).

connection(Loc1,Loc2,Bridge):-
    connect(Loc2,Loc1,Bridge).

%%%walk/3
walk(Loc1,Loc2,Path):-
    walk(Loc1,Loc2,[],Path).

walk(Loc1,Loc2,Visited,[Bridge]):-
    connection(Loc1,Loc2,Bridge),
    not(member(Bridge,Visited)).

walk(Loc1,Loc2,Visited,[Bridge|Rest]):-
    connection(Loc1,LocX,Bridge),
    not(member(Bridge,Visited)),
    walk(LocX,Loc2,[Bridge|Visited],Rest).

%%%euler/0
euler:-
    walk(_Loc1,_Loc2,Path),
    length(Path,7).
