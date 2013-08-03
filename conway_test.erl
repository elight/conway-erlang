-module(conway_test).
-include_lib("eunit/include/eunit.hrl").

life_test() ->
    Input    = [
		[alive,  dead, alive],
		[ dead, alive,  dead],
		[alive,  dead, alive]
	       ],
    Expected = [
		[ dead, alive,  dead],
		[alive,  dead, alive],		
		[ dead, alive,  dead]
	       ],
    ?assertEqual(Expected, conway:iterate(Input)).

living_neighbors_for_test() ->
    Input    = [
		[alive,  dead, alive],
		[ dead, alive,  dead],
		[alive,  dead, alive]		
	       ],
    ?assertEqual(4, conway:living_neighbors_for({2, 2}, Input)).




