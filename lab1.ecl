%%%As seen in https://people.iee.ihu.gr/~demos/Downloads/AI_Lab3.pdf

%%% figure/2
%%% Representation of the IQ Test shapes
%%% middle(S1,S2) : S1 is inside S2
figure(1, middle(triangle, square)).
figure(2, middle(circle, triangle)).
figure(3, middle(square, circle)).
figure(4, middle(square, square)).
figure(5, middle(square, triangle)).
figure(6, middle(triangle, square)).
figure(7, middle(circle, square)).
figure(8, middle(triangle, triangle)).

figure(9, bottomleft(circle, circle)).
figure(10, topleft(circle, circle)).
figure(11, bottomright(circle, circle)).
figure(12, topright(circle, circle)).
figure(13, bottomleft(square, square)).
figure(14, topleft(square, square)).
figure(15, bottomright(square, square)).
figure(16, topright(square, square)).

%%% relation/3
%%% Defines relationships of shapes
relation(middle(S1,S2), middle(S2,S1), inverse).
relation(middle(S1,_), middle(S1,_), changeout).
relation(middle(_,S2), middle(_,S2), changein).

relation(bottomleft(S1,S2), bottomright(S1,S2), lrmirror).
relation(topleft(S1,S2), topright(S1,S2), lrmirror).
relation(bottomleft(S1,S2), topleft(S1,S2), tbmirror).
relation(bottomright(S1,S2), topright(S1,S2), tbmirror).
relation(bottomright(S1,S2), topleft(S1,S2), diagmirror).
relation(bottomleft(S1,S2), topright(S1,S2), diagmirror).

%%% analogy/4
%%% Και που ξες εσυ οτι ειναι το Middle
analogy(F1,F2,F3,F4):-
	figure(F1, S1),
	figure(F2, S2),
	figure(F3, S3),
	figure(F4, S4),
	relation(S1, S2, R),
	relation(S3, S4, R),
	F3\=F4.
