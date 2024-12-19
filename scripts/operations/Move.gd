extends Operation

func isValid(src: Vector2i = Vector2i(-1,-1), dst: Vector2i = Vector2i(-1,-1)) -> bool:
	return board.move_board_valid(src, dst, false)
	
func execute(src: Vector2i = Vector2i(-1,-1), dst: Vector2i = Vector2i(-1,-1)) -> void:
	board.move_board_object(src, dst, true)
