extends Node
class_name HealthComponent

@export var max_health: float = 100
@export var health: float = 100

signal dead
signal health_changed(update_health: float)

func take_damage(damage: float):
	health -= damage
	health_changed.emit(health)
	if health <= 0:
		dead.emit()

func heal(healing: float):
	if health + healing > max_health:
		health = max_health
	else:
		health + healing
	health_changed.emit(health)
	

