-module(conway_test).
-include_lib("eunit/include/eunit.hrl").

life_test() ->
    Input    = [
		[1, 0, 1],
		[0, 1, 0],
		[1, 0, 1]
	       ],
    Expected = [
		[0, 1, 0],
		[1, 0, 1],
		[0, 1, 0]
	       ],
    ?assertEqual(Expected, conway:iterate(Input)).

neighbors_for_test() ->
    Input    = [
		[1, 0, 1],
		[0, 1, 0],
		[1, 0, 1]
	       ],
    ?assertEqual(4, conway:neighbors_for({2, 2}, Input)).




