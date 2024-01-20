extends Area2D
class_name Bullet

var direction = Vector2()
@export var damage: float = 20.0
@export var speed = 200

func shoot(gun_position, aim_position, bullet_speed):
	speed = bullet_speed
	global_position = gun_position
	direction = (aim_position - gun_position).normalized()
	rotation = direction.angle()

func _process(delta):
	position += direction * speed * delta


# Figure out bullet deletion

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	queue_free()

func _on_body_entered(body):
	queue_free()
