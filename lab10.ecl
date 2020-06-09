reading(course1,3,12).
reading(course2,5,20).
reading(course3,2,8).
reading(course4,7,22).

schedule_reads(Starts):-
    findall(C,reading(C,_,_),Courses),
    findall(D,reading(_,D,_),Durations),
    findall(Dd,reading(_,_,Dd),Deadlines),
    length(Courses,N),
    length(Starts,N),
    Starts #:: 1..inf,
    state_crossing_times(Starts,Durations,Deadlines,Ends),
    ic:maxlist(Ends,MakeSpan),
    disjunctive(Starts,Durations), %Can't study 2 at the same time
    bb_min(labeling(Starts),MakeSpan,
    bb_options{strategy:restart}).

state_crossing_times([],[],[],[]).
state_crossing_times([S|Starts],[D|Durations],[Dd|Deadlines],[E|Ends]):-
    S + D #= E,
    E #=< Dd, %End has to be before Deadline
    state_crossing_times(Starts,Durations,Deadlines,Ends).
