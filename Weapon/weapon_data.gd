extends Resource
class_name WeaponData

@export var weapon_name: String = ""
@export var weapon_sprite: Texture
@export var weapon_shoot_time: float = 1
@export var weapon_damage: float = 20

@export var reload_count: int = 6
@export var reload_time: float = 0.3

@export var max_ammo: int = 200

@export var bullet_count: int = 1
@export var bullet_spread: int = 2
@export var bullet_speed: int = 300

