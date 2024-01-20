extends Node2D
class_name WeaponEquipmentComponent

@export var equipped_weapons: Array[BaseWeaponComponent]
@export var current_weapon: BaseWeaponComponent


signal picked_up_weapon(weapon: BaseWeaponComponent)

var current_index: int = 0

const BASE_WEAPON_COMPONENT = preload("res://Weapon/base_weapon_component.tscn")

func _ready():
	for child in get_children():
		child.visible = false
	current_weapon = equipped_weapons[current_index]
	current_weapon.visible = true

func _physics_process(delta):
	current_weapon.update_target(get_global_mouse_position())

func choose_weapon(choice: int):
	if choice <= equipped_weapons.size():
		if current_weapon:
			current_weapon.visible = false
			current_weapon = equipped_weapons[choice - 1]
			if current_weapon:
				current_weapon.visible = true

func next_weapon():
	if current_index >= equipped_weapons.size() - 1:
		current_index = 0
		choose_weapon(current_index + 1)
	else:
		current_index += 1
		choose_weapon(current_index + 1)

func previous_weapon():
	if current_index <= 0:
		current_index = equipped_weapons.size() - 1
		choose_weapon(current_index + 1)
	else:
		current_index -= 1
		choose_weapon(current_index + 1)

func add_weapon(weapon: WeaponData):
	var new_weapon = BASE_WEAPON_COMPONENT.instantiate()
	new_weapon.weapon_data = weapon
	equipped_weapons.append(new_weapon)
	add_child(new_weapon)
	new_weapon.visible = false
	picked_up_weapon.emit(new_weapon)
