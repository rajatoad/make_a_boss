extends Area2D
class_name WeaponPickup

@export var weapon: WeaponData

@onready var sprite_2d = $Sprite2D

signal weapon_picked_up(weapon: WeaponData)

func _ready():
	if weapon:
		sprite_2d.texture = weapon.weapon_sprite
	#weapon.visible = false

func setup_pickup(new_weapon: WeaponData):
	weapon = new_weapon
	sprite_2d.texture = new_weapon.weapon_sprite

func _on_body_entered(body):
	print(body)
	weapon_picked_up.emit(weapon)
	queue_free()
