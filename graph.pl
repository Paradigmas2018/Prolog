:- dynamic graph/1.
:- dynamic vertex/2.
:- dynamic edge/4.


% checks if graph already exists
new_graph(Graph) :-
  graph(Graph),
  !.

% if graph does not exist, adds to the knowledge base
new_graph(Graph) :-
  assert(graph(Graph)),
  !.

% checks if vertex already exists
add_vertex(Graph, Vertex) :-
  nonvar(Graph),
  nonvar(Vertex),
  graph(Graph),
  vertex(Graph, Vertex),
  !.

% if vertex does not exist, adds to the knowledge base
add_vertex(Graph, Vertex) :-
  assert(vertex(Graph, Vertex)),
  !.

% checks if edge already exists
add_edge(Graph, Origin, Destination, Weight) :-
  nonvar(Graph),
  nonvar(Origin),
  nonvar(Destination),
  nonvar(Weight),
  graph(Graph),
  edge(Graph, Origin, Destination, _),
  retractall(edge(Graph, Origin, Destination, _)),
  add_edge(Graph, Origin, Destination, Weight),
  !.

% if edge does not exist, adds to the knowledge base
add_edge(Graph, Origin, Destination, Weight) :-
  assert(edge(Graph, Origin, Destination, Weight)),
  !.
