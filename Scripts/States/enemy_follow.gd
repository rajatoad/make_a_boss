extends State
class_name EnemyFollow


@export var move_speed: float = 40.0

var player: CharacterBody2D
var enemy: CharacterBody2D

func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 90:
		if enemy:
			enemy.velocity = direction.normalized() * move_speed
	else:
		if enemy:
			enemy.velocity = Vector2()
			Transitioned.emit(self, "attack")
	
	if direction.length() >= 150:
		Transitioned.emit(self, "idle")
