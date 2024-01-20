extends CharacterBody2D
class_name EnemyEntity

@onready var enemy_ui = $EnemyUI
@onready var sprite_2d = $Sprite2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var enemy_weapon_equipment_component: EnemyWeaponEquipmentComponent = $EnemyWeaponEquipmentComponent
@onready var weapon_pickup = $WeaponPickup

@export var weapon_data: WeaponData

const WEAPON_PICKUP = preload("res://Weapon/weapon_pickup.tscn")

func _ready():
	hitbox_component.hit_trigger.connect(health_component.take_damage)
	health_component.dead.connect(die)
	setup_health_bar_ui()
	enemy_weapon_equipment_component.player_entity = get_tree().get_first_node_in_group("Player")
	weapon_pickup.setup_pickup(enemy_weapon_equipment_component.current_weapon.weapon_data)


func setup_health_bar_ui():
	enemy_ui.health_bar.max_value = health_component.max_health
	enemy_ui.health_bar.value = health_component.health
	health_component.health_changed.connect(enemy_ui.update_health_bar)

func _physics_process(delta):
	move_and_slide()
	
	if velocity.length() > 0:
		$AnimationPlayer.play("run")
	
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	elif velocity.x < 0:
		$Sprite2D.flip_h = true

func die():
	$AnimationPlayer.play("death")
	weapon_pickup.visible = true
	remove_child(weapon_pickup)
	get_tree().root.add_child(weapon_pickup)
	weapon_pickup.global_position = global_position
	queue_free()
