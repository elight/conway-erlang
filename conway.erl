-module(conway).
-export([
	 iterate/1,
	 next_cell_state/2,
	 neighbors_for/2,
	 neighbor_coords/2,
	 cell_at/2,
	 iterate_cells/5
	]).

% 1 = alive
% 0 = dead
%
% Grid is represented by a List of Lists of arbitrary size X

next_cell_state(1, 2) ->
    1;
next_cell_state(1, 3) ->
    1;
next_cell_state(0, 3) ->
    1;
next_cell_state(_, _) ->
    0.

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
		neighbors_for({X, Y}, Grid)),
    iterate_cells(Cells, Grid, X, Y + 1, [NewCell | CellAcc]).
    
cell_at({ X, Y}, Grid) ->
    lists:nth(X, lists:nth(Y, Grid)).

neighbors_for(Coord, Grid) ->
    lists:foldl(
      fun(XY, Acc) -> Acc + cell_at(XY, Grid) end,
      0,
      neighbor_coords(Coord, Grid)).
    
neighbor_coords({ X, Y }, Grid) ->
    [ { NX, NY } ||
	NX <- [ X - 1, X, X + 1 ],
	NY <- [ Y - 1, Y, Y + 1 ],
	{ NX, NY } /= { X, Y },
	NX > 0, NY > 0,
	NX =< length(Grid), NY =< length(Grid) ].
    
