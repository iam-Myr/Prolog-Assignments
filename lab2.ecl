%%%sumn/2
%%%sumn(N, Sum)
%%%Given a natural number N,
%%%returns the sum of all numbers between 1-N
sumn(1,1).

sumn(N, R):-
	N>0, NN is N-1,
	sumn(NN,R1),
	R is R1 + N.
