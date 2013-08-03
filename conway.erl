-module(conway).
-export([
	 iterate/1,
	 living_neighbors_for/2
	]).

% Grid is represented by a List of Lists of arbitrary size X

% params:
% life/death state of cell
% number of living neighbors
next_cell_state(alive, 2) -> alive;
next_cell_state(alive, 3) -> alive;
next_cell_state(dead, 3) ->  alive;
next_cell_state(_, _) ->     dead.

iterate(Grid) ->
    iterate_row(Grid, Grid, 1, []).

iterate_row([], _, _, RowAcc) -> RowAcc;
iterate_row([ Row | Rows ], Grid, X, RowAcc) ->
    NewRow = iterate_cells(Row, Grid, X, 1, []),
    iterate_row(Rows, Grid, X + 1, RowAcc ++ [NewRow]).

iterate_cells([], _, _, _, CellAcc) -> CellAcc;
iterate_cells([ Cell | Cells ], Grid, X, Y, CellAcc) ->
    NewCell = next_cell_state(
		Cell, 
		living_neighbors_for({X, Y}, Grid)),
    iterate_cells(Cells, Grid, X, Y + 1, [NewCell | CellAcc]).
    
cell_at({ X, Y }, Grid) ->
    case lists:nth(X, lists:nth(Y, Grid)) of
	alive -> 1;
	dead  -> 0
    end.

living_neighbors_for(Coord, Grid) ->
    lists:foldl(
      fun(XY, Acc) -> Acc + cell_at(XY, Grid) end,
      0,
      coordinates_of_neighbors(Coord, Grid)).
    
coordinates_of_neighbors({ X, Y }, Grid) ->
    [ { NX, NY } ||
	NX <- lists:seq(X - 1, X + 1),
	NY <- lists:seq(Y - 1, Y + 1),
	{ NX, NY } /= { X, Y },
	NX > 0, NY > 0,
	NX =< length(Grid), NY =< length(Grid) ].
    
