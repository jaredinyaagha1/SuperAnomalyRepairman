extends Node

@onready var player = $Pdlayer
@onready var sprite2D = $Player/Sprite2D

const SCREEN_HEIGHT = 432
# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("travel_backward", Callable(self, "_travel_backward"))
	player.connect("travel_forward", Callable(self, "_travel_forward"))
#
func _travel_backward():
	var x = player.global_position.x
	var y = player.global_position.y - SCREEN_HEIGHT
	player.global_position = Vector2(x, y)
	print("traveled backward biutvh")
	
func _travel_forward():
	var x = player.global_position.x
	var y = player.global_position.y + SCREEN_HEIGHT
	player.global_position = Vector2(x, y)
	print("traveled forward")
