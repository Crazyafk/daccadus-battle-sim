class_name TurnOrderManager extends Node

var _order = []
var currIndex: int = -1 #-1 means initiative hasn't started yet
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.start() #Wait for all Characters to add themselves before starting initiative
	
func startInitiative() -> void:
	_order.sort_custom(func(a, b): return a.initiative_roll > b.initiative_roll)
	print(_order[2].board_node_2d)
	nextTurn()

func addChar(_char: Character) -> void:
	_order.append(_char)

func nextTurn() -> void:
	currIndex += 1
	if(currIndex >= _order.size()):
		currIndex = 0
	_order[currIndex].startTurn()
