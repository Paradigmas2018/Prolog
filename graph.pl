:- dynamic graph/1.
:- dynamic vertex/2.
:- dynamic edge/4.


% checks if graph already exists
new_graph(G) :-
  graph(G),
  !.

% if graph does not exist, adds to the knowledge base
new_graph(G) :-
  assert(graph(G)),
  !.

% checks if vertex already exists
add_vertex(G, V) :-
  nonvar(G),
  nonvar(V),
  graph(G),
  vertex(G, V),
  !.

% if vertex does not exist, adds to the knowledge base
add_vertex(G, V) :-
  assert(vertex(G, V)),
  !.

% checks if edge already exists
add_edge(G, U, V, Weight) :-
  nonvar(G),
  nonvar(U),
  nonvar(V),
  nonvar(Weight),
  graph(G),
  edge(G, U, V, _),
  retractall(edge(G, U, V, _)),
  add_edge(G, U, V, Weight),
  !.

% if edge does not exist, adds to the knowledge base
add_edge(G, U, V, Weight) :-
  assert(edge(G, U, V, Weight)),
  !.
