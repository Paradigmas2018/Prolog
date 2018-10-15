:- [metro_network].
:- dynamic connects_to/3.

% checks if edge already exists
add_edge(Origin, Destination, Weight, Line) :-
  nonvar(Origin),
  nonvar(Destination),
  nonvar(Weight),
  connects_to(station(Origin, Line), station(Destination, Line), _),
  retractall(connects_to(station(Origin, Line), station(Destination, Line), _)),
  add_edge(Origin, Destination, Weight, Line),
  !.

% if edge does not exist, adds to the knowledge base
add_edge(Origin, Destination, Weight, Line) :-
  assertz(connects_to(station(Origin, Line), station(Destination, Line), Weight)),
  !.

% checks if edge already exists
add_edge_intersection(Origin, Destination, Weight, Line1, Line2) :-
    nonvar(Origin),
    nonvar(Destination),
    nonvar(Weight),
    connects_to(station(Origin, Line1), station(Destination, Line2), _),
    retractall(connects_to(station(Origin, Line1), station(Destination, Line2), _)),
    add_edge(Origin, Destination, Weight, Line1, Line2),
    !.

% if edge does not exist, adds to the knowledge base
add_edge_intersection(Origin, Destination, Weight, Line1, Line2) :-
    assert(connects_to(station(Origin, Line1), station(Destination, Line2), Weight)),
    !.

% add edges for each couple station which are connected on the line
add_station_edge(_, [_|[]]).
add_station_edge(Line, [[Station|_], [Station_2|Distance]|Tail]) :-
  add_edge(Station, Station_2, Distance, Line),
  add_station_edge(Line, [[Station_2|Distance]|Tail]).

/* same work from above, but when the line is reversed, ie way back
  this done to get the proper distance for the connection */
add_station_edge_reverse(_, [_|[]]).
add_station_edge_reverse(Line, [[Station|Distance], [Station_2|Distance2]|Tail]) :-
    add_edge(Station, Station_2, Distance, Line),
    add_station_edge_reverse(Line, [[Station_2|Distance2]|Tail]).

add_intersections(_, [_|[]], _, _).
add_intersections(_, _, _, [_|[]]).
add_intersections(Line1, [[Station|_]|_], Line2, [[Station_2|_]|_]) :-
  Station = Station_2,
  add_edge_intersection(Station, Station_2, 0, Line1, Line2).
add_intersections(Line, List, Line2, [_|Tail_2]) :-
  add_intersections(Line, List, Line2, Tail_2).
add_intersections(Line, [_|Tail], Line2, List) :-
  add_intersections(Line, Tail, Line2, List).


% creates the metro network, adding edges for each line
create_intersections(Lista, Lista2) :-
  Lista = [Line, List],
  Lista2 = [Line2, List2],
  add_intersections2(Line, List, Line2, List2).

create :- findall([Line, List], train(Line, List), All),
  findall([Line, List], train(Line, List), Copy),
  create_network(All),
  create_intersections(All, Copy).

create_network([]).
create_network(List) :-
    List = [[Line, Stations]|Tail],
    add_station_edge(Line, Stations),
    reverse(List, Reverse),
    add_station_edge_reverse(Line, Reverse),
    create_network(Tail).

:- create.
