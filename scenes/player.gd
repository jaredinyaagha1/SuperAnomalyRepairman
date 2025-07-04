extends CharacterBody2D

##TODO If possible, change to animation tree for better animation handling

# Movement parameters
@export var move_speed := 200
@export var jump_speed := -350
@export var gravity := 900

# Current timeline/era
var current_era := 0  # 0 = Past, 1 = Present, 2 = Future

# Signal emitted when switching timeline
signal travel_back
signal travel_forward
signal screen_right
signal screen_left

var screen_index = 0
const MAX_SCREEN_INDEX = 2
const SCREEN_WIDTH = 768
const SCREEN_HEIGHT = 432

func _physics_process(delta):
	#print("Player position: x = %d, y = %d" % [position.x as int, position.y as int])
	handle_movement()
	apply_gravity(delta)
	#if screen_index == 0:
	print("Now at screen:", screen_index)
	if global_position.x > SCREEN_WIDTH * (screen_index + 1):
		screen_index += 1
		print("Now at screen:", screen_index)
		screen_crossed_right()
	if global_position.x < (SCREEN_WIDTH * screen_index):
		screen_index -= 1
		print("Now at screen:", screen_index)
		screen_crossed_left()
			
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		#$AnimationPlayer.play("jump")
		velocity.y = jump_speed
	move_and_slide()
	if Input.is_action_just_pressed("switch_timeline_up"):
		global_position.y += SCREEN_HEIGHT
		switch_timeline_up()
	elif Input.is_action_just_pressed("switch_timeline_down"):
		global_position.y -= SCREEN_HEIGHT
		switch_timeline_down()
	if velocity.y > 0:
		$AnimationPlayer.play("fall")
	elif velocity.y < 0:
		$AnimationPlayer.play("jump")
		

func handle_movement():
	var direction := 0
	if Input.is_action_pressed("move_left"):
		$Sprite2D.flip_h = true
		direction -= 1
	if Input.is_action_pressed("move_right"):
		$Sprite2D.flip_h = false
		direction += 1
	if direction and is_on_floor():
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")
	velocity.x = direction * move_speed

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

func switch_timeline_down():
	#current_era = (current_era + 1) % 3
	#$AnimationPlayer.play("time_shift")
	emit_signal("travel_back")

func switch_timeline_up():
	#current_era = (current_era - 1) % 3
	#if current_era < 0:
		#current_era = 2
	#$AnimationPlayer.play("time_shift")
	emit_signal("travel_forward")

func screen_crossed_left():
	emit_signal("screen_left")
	
func screen_crossed_right():
	emit_signal("screen_right")



	
