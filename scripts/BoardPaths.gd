class_name BoardPaths extends Node
## An Extension to a Board, placed as a child node of the Board.
## Handles Pathfinding across the Board.

var board : Board
var a_star: AStarGrid2D

## Called by the Board as part of its initialisation process.
## To Check if BoardPaths is initiated, check if the Board is initiated instead.
func initialise(_board : Board) -> void:
	board = _board
	a_star = AStarGrid2D.new()
	a_star.region = Rect2i(Vector2i.ZERO, board.gridsize)
	a_star.cell_size = board.cellsize
	a_star.offset = board.position
	a_star.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_AT_LEAST_ONE_WALKABLE
	a_star.update()

## Returns the Array of the Gridpos path between src and dst.
## Returns an empty array if the board is not initialised,
## Or if either input is not a valid gridpos.
func get_grid_path(src: Vector2i, dst: Vector2i) -> Array:
	if(!board.is_initiated):
		return []
	if(!board.grid_pos_valid(src) or !board.grid_pos_valid(dst)):
		return []
	return a_star.get_id_path(src, dst)
