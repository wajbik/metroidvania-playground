class_name PlayerStateRun extends PlayerState

# what happens when this state is initialized?
func init() -> void:
	#print("Init ", name )
	pass
	
# what happens when we enter this state?
func enter() -> void:
	#print("Enter ", name )
	player.animation_player.play("run")
	pass
	
# what happens when we exit this state?
func exit() -> void:
	#print("Exit ", name )
	pass
	
func handle_input( _event : InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		return jump
	return next_state
	
func process( _delta: float) -> PlayerState:
	if player.direction.x == 0:
		return idle
	elif player.direction.y > 0.5:
		return crouch
	return next_state

func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	if !player.is_on_floor():
		return fall
	return next_state
