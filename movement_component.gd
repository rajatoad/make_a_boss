extends Node
class_name MovementComponent

@export var speed: float = 100

func update_velocity(input: Input, velocity: Vector2):
	var direction: Vector2 = Vector2(
			input.get_action_strength("right") - input.get_action_strength("left"), 
			input.get_action_strength("down") - input.get_action_strength("up")
		)
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	return velocity
