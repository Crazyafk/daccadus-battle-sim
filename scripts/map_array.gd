extends Node2D

@export var cellsize : Vector2i
@export var gridsize : Vector2i
@export var default_offset : Vector2
@onready var player: Sprite2D = $"../Player"

var board = [] #2D array of Node2D, initialised in _ready. empty positions are null. 
var is_initiated := false

func _ready() -> void:
	#Initialise Board
	for i in range(gridsize.x):
		board.append([])
		for j in range(gridsize.y):
			board[i].append(null)
			
	#Complete initialisation
	is_initiated = true
	
	#Test Code
	print(set_board_object(Vector2i(0,0), player))
	print(set_board_object(Vector2i(0,0), null, true))
	print(get_board_object(Vector2i(0,0)))

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		var camera : Camera2D = get_viewport().get_camera_2d()
		var pos : Vector2 = camera.get_global_mouse_position()
		
func grid_pos_valid(pos : Vector2i) -> bool:
	return !(pos.x < 0 or pos.x >= gridsize.x or pos.y < 0 or pos.y >= gridsize.y)

# Get Grid pos of world pos. if outside of grid, return (-1,-1).
func get_grid_pos(world_pos : Vector2) -> Vector2i:
	var x = int(world_pos.x / cellsize.x)
	var y = int(world_pos.y / cellsize.y)
	var result := Vector2i(x, y)
	if grid_pos_valid(result):
		return result
	else:
		return Vector2i(-1,-1)
	
# Get World pos of Grid pos, plus offset. returns 0,0 for an invalid gridpos.
func get_world_pos(grid_pos: Vector2i, offset: Vector2 = default_offset) -> Vector2:
	if(grid_pos_valid(grid_pos)):
		var x = grid_pos.x * cellsize.x + offset.x
		var y = grid_pos.y * cellsize.y + offset.y
		return Vector2(x,y)
	else:
		return Vector2(0,0)
		
# Get object on board, except returns null if not initiated or grid_pos invalid.
func get_board_object(grid_pos: Vector2i) -> Node2D:
	if(!is_initiated or !grid_pos_valid(grid_pos)):
		return null
	else:
		return board[grid_pos.x][grid_pos.y]
		
# Set object on board, except returns false if not initiated or grid_pos invalid.
# If do_overwrite is false, also returns false if position is not empty.
func set_board_object(grid_pos: Vector2i, object: Node2D, do_overwrite : bool = false) -> bool:
	if(!is_initiated or !grid_pos_valid(grid_pos)):
		return false
	elif(!do_overwrite and get_board_object(grid_pos)):
		return false
	else:
		board[grid_pos.x][grid_pos.y] = object
		return true
