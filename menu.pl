:- include('brouxelles_metro.pl').

menu :- repeat,
  write('                          '),nl,
	write('1. Adicionar nova conexão '),nl,
	write('2. Remover uma conexão    '),nl,
  write('3. Encontrar caminho'),nl,
  write('4. Sair'),nl, nl,
  write('Escolha uma opção:'), 
  read(MenuOption), nl, MenuOption>0, MenuOption =< 4,
  trigger_action(MenuOption), MenuOption = 4, !.
  
trigger_action(1) :- 
  write(101),
  abort.