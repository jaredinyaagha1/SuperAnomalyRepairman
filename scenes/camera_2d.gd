extends Camera2D

@onready var player = $"../Player"

func _ready():
	player.connect("screen_right", Callable(self, "_on_screen_right"))
	player.connect("screen_left", Callable(self, "_on_screen_left"))
	player.connect("travel_back", Callable(self, "_travel_back"))
	player.connect("travel_forward", Callable(self, "_travel_forward"))

func _on_screen_right():
	global_position.x += 768

func _on_screen_left():
	global_position.x -= 768 

func _travel_back():
	global_position.y += 432
	
func _travel_forward():
	global_position.y -= 432
	
