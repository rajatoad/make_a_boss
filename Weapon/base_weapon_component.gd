extends Node2D
class_name BaseWeaponComponent

@onready var timer = $Timer
@onready var marker_2d = $Marker2D
@onready var sprite_2d = $Sprite2D
@onready var label = $Label

@export var weapon_data: WeaponData
@export var layer: int = 5


var weapon_name: String = ""
var weapon_sprite: Texture
var weapon_shoot_time: float = 1
var weapon_damage: float = 20

var reload_count: int = 6
var reload_time: float = 0.3
var max_ammo: int = 200

var bullet_count: int = 1
var bullet_spread: int = 2
var bullet_speed: int = 300

const BULLET = preload("res://Bullets/bullet.tscn")


var is_shooting: bool = false
var is_reloading: bool = false
var target: Vector2 

var current_clip_count: int
var current_ammo_count: int

signal update_ammo_count

func _ready():
	setup_weapon_data()

func setup_weapon_data():
	if weapon_data:
		weapon_name = weapon_data.weapon_name
		sprite_2d.texture = weapon_data.weapon_sprite
		weapon_shoot_time = weapon_data.weapon_shoot_time
		weapon_damage = weapon_data.weapon_damage

		reload_count = weapon_data.reload_count
		reload_time = weapon_data.reload_time
		
		max_ammo = weapon_data.max_ammo
		
		bullet_count = weapon_data.bullet_count
		bullet_spread = weapon_data.bullet_spread
		bullet_speed = weapon_data.bullet_speed
		
		# NEEDS TO BE CHANGED EVENTUALLY
		current_clip_count = reload_count
		current_ammo_count = randf_range(20, max_ammo)

func _physics_process(delta):
	animate_weapon()

func update_target(new_target: Vector2):
	target = new_target

func animate_weapon():
	look_at(target)
	if target.x > global_position.x:
		sprite_2d.flip_v = false
	else:
		sprite_2d.flip_v = true

func shoot():
	if current_clip_count <= 0:
		reload()
	elif not is_shooting and not is_reloading and current_clip_count >= bullet_count:
		create_bullet()

func reload():
	if not is_reloading and not current_clip_count == reload_count:
		var ammo_needed = reload_count - current_clip_count
		
		if ammo_needed > current_ammo_count:
			current_clip_count += current_ammo_count
			current_ammo_count = 0
		else:
			current_clip_count += ammo_needed
			current_ammo_count -= ammo_needed
		
		is_reloading = true
		label.visible = true
		timer.start(reload_time)

func create_bullet():
	is_shooting = true
	current_clip_count -= bullet_count
	update_ammo_count.emit(current_clip_count, current_ammo_count)
	# Used to get first bullet angle
	var half_spread = bullet_spread / 2
	# Angle between each bullet in the spread
	# subtract by 1 because it is the segments between the bullets not the bullets themselves
	var segment_angle = bullet_spread / (bullet_count - 1) if bullet_count > 1 else 0

	for i in range(bullet_count):
		# direction of bullet
		var direction = (target - marker_2d.global_position).normalized()
		# starting from negative half, it will increment to positive half
		var angle_offset = -half_spread + segment_angle * i
		# calculate radians from degrees
		var angle = deg_to_rad(angle_offset)
		# Add rotation to direction for the bullet
		var rotated_direction = direction.rotated(angle)
		# setup final target to aim for
		var final_target = marker_2d.global_position + rotated_direction
		var bullet_instance = BULLET.instantiate()
		bullet_instance.shoot(
			marker_2d.global_position, 
			final_target, 
			bullet_speed
		)
		bullet_instance.set_collision_layer_value(layer, true)
		get_tree().root.add_child(bullet_instance)
	timer.start(weapon_shoot_time)

func _on_timer_timeout():
	update_ammo_count.emit(current_clip_count, current_ammo_count)
	is_shooting = false
	is_reloading = false
	label.visible = false
