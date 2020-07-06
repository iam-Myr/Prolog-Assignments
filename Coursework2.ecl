%%% Author: Myriam Kapon
%%% Libs

:-lib(ic).
:-lib(ic_global).
:-lib(branch_and_bound).
:-lib(ic_edge_finder).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Exec 1

%%%split_check/3
split_check(Amount, Check1, Check2):-
		Check1 #:: 0..Amount,
		Check2 #:: 0..Amount,
		Amount #= Check1 + Check2,
		labeling([Check1,Check2]),
		not_contain(Check1,4),
		not_contain(Check2,4).

%%%not_contain/2
%%%not_contain(N,X)
%%%Succeeds when a Number N doesn't contain a digit X.
not_contain(0,_):- !.

not_contain(N,X):-
	  N2 is N mod 10,
	  N2 #\= X,
	  N1 is N div 10,
	  not_contain(N1,X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Exec2

backup(db,srv_d1, 0, 5, 10).
backup(db,srv_d2, 2, 8, 18).
backup(db,srv_d3, 0, 4, 11).
backup(web,srv_w1, 0, 7, 8).
backup(web,srv_w2, 3, 11, 10).

schedule_backups(DbStarts, WebStarts, MakeSpan):-
		findall(DbServer,backup(db,DbServer,_,_,_),DbServers),
		findall(DbRelease,backup(db,_,DbRelease,_,_),DbReleases),
		findall(DbDuration,backup(db,_,_,DbDuration,_),DbDurations),
		findall(DbCost,backup(db,_,_,_,DbCost),DbCosts),

		findall(WebServer,backup(web,WebServer,_,_,_),WebServers),
		findall(WebRelease,backup(web,_,WebRelease,_,_),WebReleases),
		findall(WebDuration,backup(web,_,_,WebDuration,_),WebDurations),
		findall(WebCost,backup(web,_,_,_,WebCost),WebCosts),

		length(WebServers,WebN),
		length(WebStarts,WebN),
		length(DbServers,DbN),
		length(DbStarts,DbN),

		DbStarts #:: 0..inf,
		WebStarts #:: 0..inf,

		state_crossing_times(WebStarts, WebReleases, WebDurations,WebEnds),
		state_crossing_times(DbStarts, DbReleases, DbDurations,DbEnds),
		disjunctive(DbStarts, DbDurations),
		disjunctive(WebStarts, WebDurations),

		append(WebStarts,DbStarts,Starts),
		append(DbDurations,WebDurations,Durations),
		append(DbCosts,WebCosts,Costs),
		append(DbEnds,WebEnds,Ends),
		cumulative(Starts, Durations, Costs, 25),

		ic:maxlist(Ends,MakeSpan),
		bb_min(labeling(Starts),MakeSpan,
		bb_options{strategy:restart}).

state_crossing_times([],[],[],[]).
state_crossing_times([S|Starts],[R|Releases],[D|Durations],[E|Ends]):-
		S #>= R,
		S + D #= E,
		state_crossing_times(Starts,Releases,Durations,Ends).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Exec3

arrange_list(Len,List):-
		Len #>= 7,
		length(List,Len),
		List #:: 1..Len,
		ic_global: alldifferent(List),
		labeling(List),
		element(1, List, Start), %Ιnitialization
		abs(1 - Start) #> 2,
		jump(List, Start, [Start]).

jump(List, 1, Visited):- %Last visited is 1
	length(List, N),
	length(Visited,N).

jump(List, From, Visited):-
  	element(From, List, To), %Find where to jump to
		abs(From - To) #> 2, %Jump distance must be more than 2
		not(member(To, Visited)), %Visit each digit only once
		jump(List, To, [To|Visited]).
