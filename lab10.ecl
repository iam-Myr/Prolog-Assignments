:-lib(ic).
:-lib(ic_global).
:-lib(branch_and_bound).
:-lib(ic_edge_finder).

group(a,60,2).
group(b,30,1).
group(c,50,2).
group(d,40,5).

museum(Starts):-
    findall(G,group(G,_,_),Groups),
    findall(S,group(_,S,_),Sizes),
    findall(T,group(_,_,T),Speeds),
    length(Groups,N),
    length(Starts,N), %% My vars
    Starts #:: 0..inf,
    state_crossing_times(Starts,Speeds,Ends),
    ic:maxlist(Ends,MakeSpan),
    cumulative(Starts,Speeds,Sizes,100),
    bb_min(labeling(Starts),MakeSpan,
    bb_options{strategy:restart}).

state_crossing_times([],[],[]).
state_crossing_times([S|Starts],[Sp|Speeds],[E|Ends]):-
    S + Sp #= E,
    state_crossing_times(Starts,Speeds,Ends).

%%%EXC 2
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
    Starts #:: 0..inf,
    state_crossing_times2(Starts,Durations,Deadlines,Ends),
    ic:maxlist(Ends,MakeSpan),
    disjunctive(Starts,Durations), %Can't study 2 at the same time
    bb_min(labeling(Starts),MakeSpan,
    bb_options{strategy:restart}).

    state_crossing_times2([],[],[],[]).
    state_crossing_times2([S|Starts],[D|Durations],[Dd|Deadlines],[E|Ends]):-
        S #>= 1, %Starts studying on the 1st
        S + D #= E,
        E #=< Dd, %End has to be before Deadline
        state_crossing_times2(Starts,Durations,Deadlines,Ends).
