extends Node

@onready var player = $Player
# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("travel_back", Callable(self, "_travel_back"))
	player.connect("travel_forward", Callable(self, "_travel_forward"))

func _travel_back():
	player.global_position.y += 432
	
func _travel_forward():
	player.global_position.y -= 432
