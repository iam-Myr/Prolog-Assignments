%rep_ba/2

rep_ba([rep], []).
rep_ba([rep, Next|Rest], [Next,Next|Rest]).


rep_ba([H|Rest], [H|List]):-

rep_ba(Rest,List).

rep_ba2(List,List2):-

append([Before|rep],[Next|Rest],List),
append([Before|Next],[Next,Rest],List2).
