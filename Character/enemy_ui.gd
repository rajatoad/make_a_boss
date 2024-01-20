extends Control
@onready var health_bar = $HealthBar

func update_health_bar(health: float):
	health_bar.value = health
