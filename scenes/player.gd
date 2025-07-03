extends CharacterBody2D

##TODO If possible, change to animation tree for better animation handling

# Movement parameters
@export var move_speed := 200
@export var jump_speed := -350
@export var gravity := 900

# Current timeline/era
var current_era := 0  # 0 = Past, 1 = Present, 2 = Future

# Signal emitted when switching timeline
signal timeline_switched(new_era)

func _physics_process(delta):
	
	handle_movement()
	apply_gravity(delta)
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		#$AnimationPlayer.play("jump")
		velocity.y = jump_speed
	move_and_slide()
	if Input.is_action_just_pressed("switch_timeline_up"):
		switch_timeline_up()
	elif Input.is_action_just_pressed("switch_timeline_down"):
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

func switch_timeline_up():
	current_era = (current_era + 1) % 3
	$AnimationPlayer.play("time_shift")
	emit_signal("timeline_switched", current_era)

func switch_timeline_down():
	current_era = (current_era - 1) % 3
	if current_era < 0:
		current_era = 2
	$AnimationPlayer.play("time_shift")
	
	emit_signal("timeline_switched", current_era)
