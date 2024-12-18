class_name BoardNode2D extends Node2D
##Base Class for a node occupying a position on the Board.

##Base Class for a node occupying a position on the Board.
##Assumes a Board object named Board is at the top of the scene, will not work otherwise.
##Assigns self to the Board space it occupies on ready.

signal node_clicked #Emitted by the Board directly
@onready var board: Board = $"../Board"
@export var reset_position: bool = true
@export var use_default_offset: bool = true
@export var offset: Vector2 = Vector2(0,0)

func _ready() -> void:
	var isError: bool
	if(use_default_offset):
		isError = !board.set_board_object_here(self, reset_position)
	else:
		isError = !board.set_board_object_here(self, reset_position, offset)
	assert(!isError)
