extends Node2D
class_name EnemyWeaponEquipmentComponent

@export var equipped_weapons: Array[BaseWeaponComponent]
@export var current_weapon: BaseWeaponComponent
@export var player_entity: PlayerEntity

var current_index: int = 0

func _ready():
	for child in get_children():
		child.visible = false
	current_weapon = equipped_weapons[current_index]
	current_weapon.visible = true

func _physics_process(delta):
	current_weapon.update_target(player_entity.global_position)

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

func add_weapon(weapon: BaseWeaponComponent):
	equipped_weapons.append(weapon)
	weapon.get_parent().remove_child(weapon)
	add_child(weapon)
