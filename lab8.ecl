:-lib(ic).

%%%ASK 2
weight(10).
weight(20).
weight(30).
weight(50).
weight(60).
weight(90).
weight(100).
weight(150).
weight(250).
weight(500).

%1.Metavlhtes
%2.Pedia
%3.Periorismous

balance_lights([W1,W2,W3,W4],Weight):-
    findall(W,weight(W),Domain), %Etsi vriskw to pedio timwn 10-500
    [W1,W2,W3,W4] #:: Domain,
    %Psaxnw th roph
    5*W1 #= 5*W2 + 20*W3 + 40*W4,
    ic_global: alldifferent([W1,W2,W3,W4]),
    sumlist([W1,W2,W3,W4],Weight),
    labeling([W1,W2,W3,W4]). %Anazhthsh

%%%ASK 3
num_gen([M1,5,M3,M4,3],[N1,N2,0,N4,1]):-
    [M1,M3,M4,N1,N2,N4] #:: [0..9],
    alldifferent([M1,M3,M4,N1,N2,N4,5,3,0,1])
    N1 #= M1*10000 + 5*1000 + M3*100 + M4*10 + 3*1,
    N2 #= N1*10000 + N2*1000 + 0*100 + N4*10 + 1*1,
    12848 #= abs(N1-N2),
    labeling([M1,M3,M4,N1,N2,N4]).
