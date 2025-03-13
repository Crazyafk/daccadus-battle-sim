class_name Operation extends Node

@onready var board: Board = get_tree().get_current_scene().find_child("Board")
@onready var d: DieRoller = get_tree().get_current_scene().find_child("DieRoller")
	
func isValid(_src: Vector2i = Vector2i(-1,-1), _dst: Vector2i = Vector2i(-1,-1)) -> bool:
	return false
	
func execute(_src: Vector2i = Vector2i(-1,-1), _dst: Vector2i = Vector2i(-1,-1)) -> void:
	pass
