class_name DieRoller extends Node

@onready var rng = RandomNumberGenerator.new()

# Takes a string and parses it, and rolls dice.
# e.g. "1d20" or "3d8"
func roll(input : String) -> int:
	var splitInput = input.split("d")
	var n : int = int(splitInput[0])
	var d : int = int(splitInput[1])
	var result : int = 0
	for i in range(n):
		result += rng.randi_range(1, d)
	return result
