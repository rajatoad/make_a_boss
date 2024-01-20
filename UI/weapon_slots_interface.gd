extends Control

@export var equipped_weapons: Array[BaseWeaponComponent]
const WEAPON_SLOT = preload("res://UI/weapon_slot.tscn")
@onready var grid_container = $GridContainer

#func _ready():
	#for weapon in equipped_weapons:
		#add_weapon(weapon)

func add_weapon(weapon: BaseWeaponComponent):
	var new_slot = WEAPON_SLOT.instantiate()
	new_slot.weapon_data = weapon
	weapon.update_ammo_count.connect(new_slot.update_clip_count)
	grid_container.add_child(new_slot)
