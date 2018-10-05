:- [graph, metro_network].

:- new_graph(metro).

% add ertices
add_vertices([]).
add_vertices([[Station|_]|Tail]) :-
  add_vertex(metro, Station),
  add_vertices(Tail).


% add edges for each couple station which are connected on the line
add_station_edge([_|[]]).
add_station_edge([[Station|_], [Station_2|Distance]|Tail]) :-
  add_edge(metro, Station, Station_2, Distance),
  add_station_edge([[Station_2|Distance]|Tail]).

/* same work from above, but when the line is reversed, ie way back
  this done to get the proper distance for the connection */
add_station_edge_reverse([_|[]]).
add_station_edge_reverse([[Station|Distance], [Station_2|Distance2]|Tail]) :-
    add_edge(metro, Station, Station_2, Distance),
    add_station_edge_reverse([[Station_2|Distance2]|Tail]).

% creates the metro network, adding edges for each line
create_network :- train(_, List),
  add_vertices(List),
  add_station_edge(List),
  reverse(List, Reverse),
  add_station_edge_reverse(Reverse).

:- create_network.
