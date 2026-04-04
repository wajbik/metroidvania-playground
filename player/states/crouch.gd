class_name PlayerStateCrouch extends PlayerState

@export var deceleration_rate : float = 10
# what happens when this state is initialized?
func init() -> void:
	#print("Init ", name )
	pass
	
# what happens when we enter this state?
func enter() -> void:
	player.animation_player.play("crouch")
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = false
	#player.sprite.scale.y = 0.625
	#player.sprite.position.y = -15
	pass
	
# what happens when we exit this state?
func exit() -> void:
	#print("Exit ", name )
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	#player.sprite.scale.y = 1.0
	#player.sprite.position.y = -24
	pass
	
func handle_input( _event : InputEvent) -> PlayerState:

	if _event.is_action_pressed("jump"):
		player.one_way_platform_shape_cast.force_shapecast_update()
		# enable falling from one way platforms
		if player.one_way_platform_shape_cast.is_colliding():
			player.position.y += 4
			return fall
		return jump
	return next_state
	
func process( _delta: float) -> PlayerState:
	if player.direction.y <= 0.5:
		return idle
	return next_state

func physics_process(_delta: float) -> PlayerState:
	player.velocity.x -= player.velocity.x * deceleration_rate * _delta
	if !player.is_on_floor():
		return fall
	return next_state
	
