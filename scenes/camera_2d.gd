extends Camera2D

@export var tile_size := 16
@export var target_tiles_x := 72
@export var target_tiles_y := 48

func _ready():
	adjust_zoom()

func adjust_zoom():
	var viewport_size = get_viewport_rect().size

	var target_world_width = target_tiles_x * tile_size
	var target_world_height = target_tiles_y * tile_size

	var scale_x = viewport_size.x / target_world_width
	var scale_y = viewport_size.y / target_world_height

	var scale = min(scale_x, scale_y)

	zoom = Vector2(1 / scale, 1 / scale)
