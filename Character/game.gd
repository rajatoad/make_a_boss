extends Node2D

@onready var ui = $UI

@onready var player_entity = $PlayerEntity
@onready var pickups = $Pickups
@onready var weapon_slots_interface = $UI/WeaponSlotsInterface


func _ready():
	setup_health()
	setup_pickups()
	setup_weapon_slots()

func setup_health():
	ui.health_bar.max_value = player_entity.health_component.max_health
	ui.health_bar.value = player_entity.health_component.health
	player_entity.health_component.health_changed.connect(ui.update_health_bar)

func setup_pickups():
	for pickup in get_tree().get_nodes_in_group("pickup"):
		pickup.weapon_picked_up.connect(player_entity.weapon_equipment_component.add_weapon)

func setup_weapon_slots():
	player_entity.weapon_equipment_component.picked_up_weapon.connect(weapon_slots_interface.add_weapon)
	for weapon in player_entity.weapon_equipment_component.equipped_weapons:
		weapon_slots_interface.add_weapon(weapon)
