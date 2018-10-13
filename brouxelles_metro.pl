:- include('data/metro.pl').

%  Get path from start position to destionation
goes_to(From, To, Path, Distance) :-
	travel(From, To, [From], AccPath, Distance),
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

% Convert distance in distance in time to destionation
time_to(Distance) :-
	Factor is 360 // 100,
	Y is Distance // Factor,
	write(Factor), nl, 
	write(Y).