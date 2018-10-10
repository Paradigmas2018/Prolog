
% Facts Connect to - connects_to(station(name, line), station(name, line), distance_between_stations)

% Intersection - Line 1/Line 2

connects_to(station(gare_de_louest , line_1), station(gare_de_louest, line_2), 0).
connects_to(station(beekkant , line_1), station(beekkant, line_2), 0).
connects_to(station(arts_loi , line_1), station(arts_loi, line_2), 0).

% Line 1 - BLUE 

connects_to(station(gare_de_louest , line_1), station(beekkant, line_1), 540).
connects_to(station(beekkant , line_1), station(etangs_noirs, line_1), 780).
connects_to(station(etangs_noirs , line_1), station(comte_de_flandre, line_1), 580).
connects_to(station(comte_de_flandre , line_1), station(sainte_catherine, line_1), 610).
connects_to(station(sainte_catherine , line_1), station(de_brouckere, line_1), 350).
connects_to(station(de_brouckere , line_1), station(gare_centrale, line_1), 670).
connects_to(station(gare_centrale , line_1), station(parc, line_1), 410).
connects_to(station(parc , line_1), station(arts_loi, line_1), 450).
connects_to(station(arts_loi , line_1), station(maelbeek, line_1), 580).
connects_to(station(maelbeek , line_1), station(schuman, line_1), 390).
connects_to(station(connects_to(station(gare_centrale , line_1), station(parc, line_1), 410).
connects_to(station(parc , line_1), station(arts_loi, line_1), 450).
connects_to(station(arts_loi , line_1), station(maelbeek, line_1), 580).
connects_to(station(maelbeek , line_1), station(schuman, line_1), 390). , line_1), station(parc, line_1), 410).
connects_to(station(schuman , line_1), station(merode, line_1), 1190).
connects_to(station(merode , line_1), station(montgomery, line_1), 670).
connects_to(station(montgomery , line_1), station(josephine_charlotte, line_1), 480).
connects_to(station(josephine_charlotte , line_1), station(gribaumont, line_1), 430).
connects_to(station(gribaumont , line_1), station(tomberg, line_1), 520).
connects_to(station(tomberg , line_1), station(roodebeek, line_1), 890).
connects_to(station(roodebeek , line_1), station(vandervelde, line_1), 880).
connects_to(station(vandervelde , line_1), station(alma, line_1), 2090).
connects_to(station(alma , line_1), station(crainheim, line_1), 1960).
connects_to(station(crainheim , line_1), station(stockel, line_1), 940).

% Line 2 - ORANGE

connects_to(station(simonis , line_2), station(osseghem, line_2), 780).
connects_to(station(osseghem , line_2), station(beekkant, line_2), 400).
connects_to(station(beekkant , line_2), station(gare_de_louest, line_2), 540).
connects_to(station(gare_de_louest , line_2), station(delacroix, line_2), 500).
connects_to(station(delacroix , line_2), station(clemenceau, line_2), 610).
connects_to(station(clemenceau , line_2), station(gare_du_midi, line_2), 740).
connects_to(station(gare_du_midi , line_2), station(porte_de_hal, line_2), 600).
connects_to(station(porte_de_hal , line_2), station(hotel_des_monnaies, line_2), 430).
connects_to(station(hotel_des_monnaies , line_2), station(louise, line_2), 470).
connects_to(station(louise , line_2), station(porte_de_namur, line_2), 590).
connects_to(station(porte_de_namur , line_2), station(trone, line_2), 430).
connects_to(station(trone , line_2), station(arts_loi, line_2), 520).
connects_to(station(arts_loi , line_2), station(madou, line_2), 490).
connects_to(station(madou , line_2), station(botanique, line_2), 460).
connects_to(station(botanique , line_2), station(rogier, line_2), 530).
connects_to(station(rogier , line_2), station(yser, line_2), 450).
connects_to(station(yser , line_2), station(ribaucourt, line_2), 1120).
connects_to(station(ribaucourt , line_2), station(elisabeth, line_2), 580).