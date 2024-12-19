extends Node

@onready var board_node_2d: BoardNode2D = $".."
@onready var board: Board = get_tree().get_current_scene().find_child("Board")
@onready var selected_operation: Operation = $Operations/Move
var world_pos: Vector2: 
	get: return board_node_2d.get_grid_pos()

func _ready() -> void:
	board.tile_clicked.connect(_board_tile_clicked)
	
func _board_tile_clicked(click_pos: Vector2i) -> void:
	print("tile clicked!")
	if(selected_operation.isValid(world_pos, click_pos)):
		selected_operation.execute(world_pos, click_pos)
	else:
		print("operation failed")
