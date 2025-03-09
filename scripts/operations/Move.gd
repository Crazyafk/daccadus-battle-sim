extends Operation

@onready var timer: Timer = $Timer

func isValid(src: Vector2i = Vector2i(-1,-1), dst: Vector2i = Vector2i(-1,-1)) -> bool:
	return board.move_board_valid(src, dst, false)
	
func execute(src: Vector2i = Vector2i(-1,-1), dst: Vector2i = Vector2i(-1,-1)) -> void:
	var path : Array
	path = board.board_paths.get_grid_path(src, dst)
	print(path)
	for i in range(path.size()-1):
		print(path[i])
		print(board.move_board_object(path[i], path[i+1], true))
		timer.start()
		await timer.timeout
