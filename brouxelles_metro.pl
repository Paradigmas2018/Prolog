:- include('data/metro.pl').

%  Get path from start position to destionation
goes_to(From, To, Path, Duration) :-
	travel(From, To, [From], AccPath, Duration),
	reverse(AccPath, Path).

% Connects stations according to desired position 
travel(From, To, PathSoFar, [To|PathSoFar], Distance) :-
	connects_to(From, To, Distance).

% Connects stations according to desired position
travel(From, To, PathSoFar, Path, Distance) :-
	connects_to(From, NextStation, TravelDistance),
	NextStation \== To,
	\+member(NextStation, PathSoFar),
	travel(NextStation, To, [NextStation|PathSoFar], Path, AccDistance),
	Distance is TravelDistance + AccDistance.