class_name Character extends Node

# Common Character Stats
@export var strength: int = 0
@export var dexterity: int = 0
@export var constitution: int = 0
@export var intelligence: int = 0
@export var wisdom: int = 0
@export var charisma: int = 0
@export var speed: int = 12
var initiative: int:
	get: return dexterity + wisdom

# Working Variables
var isMyTurn: bool = false
var world_pos: Vector2: 
	get: return board_node_2d.get_grid_pos()
var initiative_roll: int

# References
@onready var board_node_2d: BoardNode2D = $".."
@onready var _main_scene = get_tree().get_current_scene()
@onready var board: Board = _main_scene.find_child("Board")
@onready var d: DieRoller = _main_scene.find_child("DieRoller")
@onready var turn_order_manager: TurnOrderManager = _main_scene.find_child("TurnOrderManager")
@onready var selected_operation: Operation = $Operations/Move

func _ready() -> void:
	board.tile_clicked.connect(_board_tile_clicked)
	initiative_roll = d.roll("1d20") + initiative
	turn_order_manager.addChar(self)
	
func _board_tile_clicked(click_pos: Vector2i) -> void:
	if(isMyTurn):
		print("tile clicked!")
		if(selected_operation.isValid(world_pos, click_pos)):
			selected_operation.execute(world_pos, click_pos)
		else:
			print("operation failed")
		
func startTurn() -> void:
	isMyTurn = true
	
func endTurn() -> void:
	isMyTurn = false
	turn_order_manager.nextTurn()
