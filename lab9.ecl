:-lib(ic).
:-lib(ic_global).
:-lib(branch_and_bound).
:-lib(ic_edge_finder).
:-use_module(library(lists)).


%%%%%%%%%%%%EXC 1
% worker(Id,Job,Cost,Days)
worker(1,[4,1,3,5,6],[30,8,30,20,10]).
worker(2,[6,3,5,2,4],[140,20,70,10,90]).
worker(3,[8,4,5,7,10],[60,80,10,20,30]).
worker(4,[3,7,8,9,1],[30,40,10,70,10]).
worker(5,[7,1,5,6,4],[40,10,30,20,10]).
worker(6,[8,4,7,9,5],[20,100,130,220,50]).
worker(7,[5,6,7,4,10],[30,30,30,20,10]).
worker(8,[2,6,10,8,3],[50,40,20,10,60]).
worker(9,[1,3,10,9,6],[50,40,10,20,30]).
worker(10,[1,2,7,9,3],[20,20,30,40,50]).


solve(Jobs,Cost):-
    findall(W,worker(W,_,_),Workers),
    constrain_workers(Workers,Jobs,Costs),
    ic_global:alldifferent(Jobs),
    sumlist(Costs,Cost),
    bb_min(labeling(Jobs),Cost,_).

constrain_workers([],[],[]).
constrain_workers([W|Rest],[J|Jobs],[C|Costs]):-
	worker(W,MyJobs,MyCosts),
	element(I,MyJobs,J),
	element(I,MyCosts,C),
	constrain_workers(Rest,Jobs,Costs).

%%%%%%%%%%%%EXC 3
student(alex,[4,1,3,5,6]).
student(nick,[6,3,5,2,4]).
student(jack,[8,4,5,7,10]).
student(helen,[3,7,8,9,1]).
student(maria,[7,1,5,6,4]).
student(evita,[8,4,7,9,5]).
student(jacky,[5,6,7,4,10]).
student(peter,[2,6,10,8,3]).
student(john,[1,3,10,9,6]).
student(mary,[1,6,7,9,10]).


%%% Stating the constraints
alloc_constraints([],[],0).
alloc_constraints([(X,Thesis)|Rest],[Thesis|RestThesis],TotalCost):-
	student(X,Prefs),
	Thesis::Prefs,
	element(Cost,Prefs,Thesis),
	alloc_constraints(Rest,RestThesis,RCost),
	TotalCost #= Cost + RCost.

state_constraints(Students,Theses,Cost):-
	alloc_constraints(Students,Theses,Cost),
	alldifferent(Theses).

%%% Top level predicate to solve the problem.
solve2(Stds,Cost):-
	collect_students(Stds),
	state_constraints(Stds,Theses,Cost),
        bb_min(labeling(Theses),Cost,_).

%%% collecting the number of students.
collect_students(Stds):-
	findall((S,_),student(S,_),Stds).

%%% ΕΧΨ 4
box(1,140).
box(2,200).
box(3,450).
box(4,700).
box(5,120).
box(6,300).
box(7,250).
box(8,125).
box(9,600).
box(10,650).



load_trucks(Truck1,Load1,Truck2,Load2):-
    findall(W,box(_,W), Weights),
	length(Truck1,3),
	length(Truck2,4),

	assignBoxes(Truck1,Weights,Load1),
	Load1 #=< 1200,

	assignBoxes(Truck2,Weights,Load2),
	Load2 #=< 1350,

	append(Truck1,Truck2,Trucks),
	ic_global:alldifferent(Trucks),

	Load #= 2550 - (Load1 + Load2),
        bb_min(labeling(Trucks),Load,bb_options{strategy:restart}).


assignBoxes([],_,0).
assignBoxes([Box|Rest],Weights,W):-
        element(Box,Weights,WBox),
	assignBoxes(Rest,Weights,RW),
	W #= RW + WBox.

%%%ΕXC 5
provider(a,[0,750,1000,1500],[0,10,13,17]).
provider(b,[0,500,1250,2000],[0,8,12,22]).
provider(c,[0,1000,1750,2000],[0,15,18,25]).
provider(d,[0,1000,1500,1750],[0,13,15,17]).

space(Plans,Cost):-
    [Space] #:: [3600..4600],
    findall(P,provider(P,_,_),Providers),
    constrain_providers(Providers,Plans,Costs),
    sumlist(Costs,Cost),
    sumlist(Plans, Space),
    bb_min(labeling(Plans),Cost,_).

constrain_providers([],[],[]).
constrain_providers([P|Rest],[Pl|Plans],[C|Costs]):-
    provider(P,MyPlans,MyCosts),
    element(I,MyPlans,Pl),
	element(I,MyCosts,C),
    constrain_providers(Rest,Plans,Costs).
