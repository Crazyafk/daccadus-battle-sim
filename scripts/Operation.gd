class_name Operation extends Node

@onready var board: Board = get_tree().get_current_scene().find_child("Board")
	
func isValid(src: Vector2i = Vector2i(-1,-1), dst: Vector2i = Vector2i(-1,-1)) -> bool:
	return false
	
func execute(src: Vector2i = Vector2i(-1,-1), dst: Vector2i = Vector2i(-1,-1)) -> void:
	pass
