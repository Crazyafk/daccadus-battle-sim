class_name Board extends Node2D
##Square Game Board, that manages an array representation of BoardNode2Ds,
##and provides functions for managing that array and translating coordinates.

signal tile_clicked()					#Emitted with grid coordinates of the tile clicked
@export var cellsize : Vector2i 		#The size of each grid cell in pixels
@export var gridsize : Vector2i			#The size of the grid in cells
@export var default_offset : Vector2	#Default offset when getting a worldpos from a gridpos
@onready var player: BoardNode2D = $"../Player"
@onready var map_array: Node2D = $"."

var _board = [] #2D array of BoardNode2D, initialised in _ready. empty positions are null. 
var is_initiated := false

func _ready() -> void:
	#Initialise Board
	for i in range(gridsize.x):
		_board.append([])
		for j in range(gridsize.y):
			_board[i].append(null)
			
	#Complete initialisation
	is_initiated = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		var camera : Camera2D = get_viewport().get_camera_2d()
		var pos : Vector2 = camera.get_global_mouse_position()
		var gridpos : Vector2i = get_grid_pos(pos)
		tile_clicked.emit(gridpos)
		
		var clickedNode : BoardNode2D = get_board_object(gridpos)
		if(clickedNode):
			clickedNode.node_clicked.emit()
		
func grid_pos_valid(pos : Vector2i) -> bool:
	return !(pos.x < 0 or pos.x >= gridsize.x or pos.y < 0 or pos.y >= gridsize.y)

## Get Grid pos of world pos. if outside of grid, return (-1,-1).
func get_grid_pos(world_pos : Vector2) -> Vector2i:
	var x = int((world_pos.x - map_array.global_position.x) / cellsize.x)
	var y = int((world_pos.y - map_array.global_position.y) / cellsize.y)
	var result := Vector2i(x, y)
	if grid_pos_valid(result):
		return result
	else:
		return Vector2i(-1,-1)
	
## Get World pos of Grid pos, plus offset. returns 0,0 for an invalid gridpos.
func get_world_pos(grid_pos: Vector2i, offset: Vector2 = default_offset) -> Vector2:
	if(grid_pos_valid(grid_pos)):
		var x = grid_pos.x * cellsize.x + offset.x + map_array.global_position.x
		var y = grid_pos.y * cellsize.y + offset.y + map_array.global_position.y
		return Vector2(x,y)
	else:
		return Vector2(0,0)
		
## Get object on board, except returns null if not initiated or grid_pos invalid.
func get_board_object(grid_pos: Vector2i) -> Node2D:
	if(!is_initiated or !grid_pos_valid(grid_pos)):
		return null
	else:
		return _board[grid_pos.x][grid_pos.y]
		
## Set object on board, except returns false if not initiated or grid_pos invalid.
## If allow_overwrite is false, also returns false if position is not empty.
func set_board_object(object: BoardNode2D, grid_pos: Vector2i, allow_overwrite : bool = false) -> bool:
	if(!is_initiated or !grid_pos_valid(grid_pos)):
		return false
	elif(!allow_overwrite and get_board_object(grid_pos)):
		return false
	else:
		_board[grid_pos.x][grid_pos.y] = object
		return true
		
## Sets given object to the grid position relevant for its global position.
## Returns false if not initiated or if its global position is outside the grid.
## If allow_overwrite is false, also returns false if position is not empty.
## If reset_position is true, also sets the object's position using the offset.
func set_board_object_here(object: BoardNode2D, reset_position : bool = false,
offset: Vector2 = default_offset, allow_overwrite : bool = false) -> bool:
	var grid_pos : Vector2i = get_grid_pos(object.global_position)
	if(!set_board_object(object, grid_pos, allow_overwrite)):
		return false
	else:
		if(reset_position):
			object.set_global_position(get_world_pos(grid_pos, offset))
		return true
