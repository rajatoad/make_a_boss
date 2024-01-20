extends MarginContainer

@export var weapon_data: BaseWeaponComponent
@onready var weapon_image = $WeaponImage
@onready var ammo_label = $AmmoLabel

func _ready():
	setup_weapon()

func setup_weapon():
	if weapon_data:
		print(weapon_data.weapon_sprite)
		weapon_image.texture = weapon_data.sprite_2d.texture
		ammo_label.text = "%s / %s" % [weapon_data.current_clip_count, weapon_data.current_ammo_count]

func update_clip_count(clip_count: int, ammo_count: int):
	ammo_label.text = "%s / %s" % [clip_count, ammo_count]
