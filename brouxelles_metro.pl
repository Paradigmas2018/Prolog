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
	read(NewStation), nl,
	write('Qual linha da estação?'), nl,
	read(LineOfNewStation),
	write('A qual o nome estação ela esta conectada?'), nl,
	read(ConnectedStation),
	write('A qual a linha da estação que ela esta conectada?'), nl,
	read(LineOfConnectedStation),
	write('Qual a distância média em minutos?'), nl,
	read(Distance),
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
			Distance
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
			Distance
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
			Distance
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
			Distance
		)
	).
	

doit(3):-
  write('Qual nome da estação origem?'), nl,
	read(Origin),
	write('A qual o nome estação destino?'), nl,
	read(Destination),
	goes_to(station(Origin,_), station(Destination,_), Path, Distance),
	DistanceInMinutes is Distance / 540,
	write('Caminho: '), writePath(Path), nl,
	write('Tempo: '),  format('~2f', [DistanceInMinutes]),!, write(' minutos'), nl.

doit(4):-
    abort.

writePath([]).
writePath([station(StationName, Line1)|[station(StationName,_)|[station(StationName,_)|[station(StationName,Line2)|Path]]]]) :-
	ansi_format(fg(red), '~w', [StationName]),
  ansi_format(fg(white), '~nTroca de linha: ~w ❯ ~w ~n', [Line1, Line2]),
	writePath(Path).
writePath([station(StationName, Line1)|[station(StationName,_)|[station(StationName,Line2)|Path]]]) :-
	ansi_format(fg(red), '~w', [StationName]),
	ansi_format(fg(white), '~nTroca de linha: ~w ❯ ~w ~n', [Line1, Line2]),
	writePath(Path).
writePath([station(StationName, Line1)|[station(StationName,Line2)|Path]]) :-
	ansi_format(fg(red), '~w', [StationName]),
	ansi_format(fg(white), '~nTroca de linha: ~w ❯ ~w ~n', [Line1, Line2]),
	writePath(Path).
writePath([station(StationName, _)|[]]) :-
  ansi_format(fg(red), '~w', [StationName]).
writePath([station(StationName, _)|Path]) :-
  ansi_format(fg(red), '~w', [StationName]),
  ansi_format(fg(white), '~w', [' -> ']),
	writePath(Path).


%  Get path from start position to destination
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
