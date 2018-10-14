:- include('data/metro.pl').

menu :- repeat,
    write('                          '),nl,
	write('1. Adicionar nova conexão '),nl,
	write('2. Remover uma conexão    '),nl,
    write('3. Encontrar caminho'),nl,
    write('4. Sair                           '),nl,
    write('Escolha uma opção:'),nl,
    read(Choice), Choice>0, Choice =<4,
    doit(Choice), Choice=4, !.

doit(1):-
	write('Qual nome da estação?'), nl,
	read(NewStation),
	write('Qual linha da estação?'), nl,
	read(LineOfNewStation),
	write('A qual o nome estação ela esta conectada?'), nl,
	read(ConnectedStation),
	write('A qual a linha da estação que ela esta conectada?'), nl,
	read(LineOfConnectedStation),
	write('Qual a distância média em minutos?'), nl,
	read(Time),
	assertz(
		connects_to(
			station(
				NewStation, 
				LineOfNewStation
			), 
			station(
				ConnectedStation, 
				LineOfConnectedStation
			), 
			Time
		)
	),
	assertz(
		connects_to(
			station(
				ConnectedStation, 
				LineOfConnectedStation
			), 
			station(
				NewStation, 
				LineOfNewStation
			), 
			Time
		)
	).

doit(2) :-
    write('Qual nome da estação?'), nl,
	read(Station),
	write('A qual o nome estação ela esta conectada?'), nl,
	read(ConnectedStation),
	retract(
		connects_to(
			station(
				Station, 
				_
			), 
			station(
				ConnectedStation, 
				_
			), 
			Time
		)
	),
	retract(
		connects_to(
			station(
				ConnectedStation, 
				_
			), 
			station(
				Station, 
				_
			), 
			Time
		)
	).
	

doit(3):-
    write('Qual nome da estação origem?'), nl,
	read(Origin),
	write('A qual o nome estação destino?'), nl,
	read(Destination),
	goes_to(station(Origin,_), station(Destination,_), Path, Duration),
	write('Caminho: '), writePath(Path), nl,
	write('Distância: '), write(Duration),!, write(' metros'), nl.

doit(4):-
    abort.

writePath([]).
writePath([station(StationName,Line1)|[station(StationName,_)|[station(StationName,_)|[station(StationName,Line2)|Path]]]]) :-
	write(StationName), write('('), write(Line1), write('->'),write(Line2),write(')'), write(' -> '),
	writePath(Path).
writePath([station(StationName,Line1)|[station(StationName,_)|[station(StationName,Line2)|Path]]]) :-
	write(StationName), write('('), write(Line1), write('->'),write(Line2),write(')'), write(' -> '),
	writePath(Path).
writePath([station(StationName,Line1)|[station(StationName,Line2)|Path]]) :-
	write(StationName), write('('), write(Line1), write('->'),write(Line2),write(')'), write(' -> '),
	writePath(Path).
writePath([station(StationName,Line)|[]]) :-
	write(StationName),write('('),write(Line),write(')').
writePath([station(StationName,Line)|Path]) :-
	write(StationName),!,write('('),write(Line),write(')'), write(' -> '),
	writePath(Path).


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