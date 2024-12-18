extends Node2D

@export var cellsize : Vector2i
@export var gridsize : Vector2i
@export var default_offset : Vector2

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		var camera : Camera2D = get_viewport().get_camera_2d()
		var pos : Vector2 = camera.get_global_mouse_position()

# Get Grid pos of world pos. if outside of grid, return (-1,-1).
func get_grid_pos(world_pos : Vector2) -> Vector2i:
	var x = int(world_pos.x / cellsize.x)
	var y = int(world_pos.y / cellsize.y)
	if(x < 0 or x >= gridsize.x or y < 0 or y >= gridsize.y):
		return Vector2i(-1,-1)
	return Vector2i(x, y)
	
# Get World pos of Grid pos, plus offset. returns 0,0 for an invalid gridpos.
func get_world_pos(grid_pos: Vector2i, offset: Vector2 = default_offset) -> Vector2:
	if(grid_pos.x < 0 or grid_pos.x >= gridsize.x or grid_pos.y < 0 or grid_pos.y >= gridsize.y):
		return Vector2(0,0)
	var x = grid_pos.x * cellsize.x + offset.x
	var y = grid_pos.y * cellsize.y + offset.y
	return Vector2(x,y)
