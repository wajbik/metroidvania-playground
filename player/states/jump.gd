class_name PlayerStateJump extends PlayerState

@export var jump_velocity : float = 450.0

# what happens when this state is initialized?
func init() -> void:
	#print("Init ", name )
	pass
	
# what happens when we enter this state?
func enter() -> void:
	# Play animation
	player.animation_player.play("jump")
	player.animation_player.pause()
	#player.add_debug_indicator(Color.LIME_GREEN)
	player.velocity.y = -jump_velocity
	
	# check if this is a buffer jump
	# if it is, handle jump button release condition
	if player.previous_state == fall and not Input.is_action_pressed("jump"):
		# line to avoid one frame changes potential bugs
		await get_tree().physics_frame
		player.velocity.y *= 0.5
		player.change_state(fall)
	
	pass
	
# what happens when we exit this state?
func exit() -> void:
	#print("Exit ", name )
	#player.add_debug_indicator(Color.YELLOW)
	
	pass
	
func handle_input( event : InputEvent) -> PlayerState:
	# handle inputs
	if event.is_action_released("jump"):
		player.velocity.y *= 0.5
		return fall
	return next_state
	
func process( _delta: float) -> PlayerState:
	set_jump_frame()
	return next_state

func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y >= 0:
		return fall
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
	
func set_jump_frame() -> void:
	var frame : float = remap(player.velocity.y, -jump_velocity, 0.0, 0.0, 0.5)
	player.animation_player.seek(frame, true)
	pass
