extends CharacterBody2D
class_name PlayerEntity

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var weapon_equipment_component: WeaponEquipmentComponent = $WeaponEquipmentComponent
@onready var movement_component = $MovementComponent

func _ready():
	hitbox_component.hit_trigger.connect(health_component.take_damage)
	health_component.dead.connect(die)

func _input(event):
	if event.is_action_pressed("shoot"):
		weapon_equipment_component.current_weapon.shoot()
	if event.is_action_pressed("reload"):
		weapon_equipment_component.current_weapon.reload()
	if event.is_action_pressed("next_weapon"):
		weapon_equipment_component.next_weapon()
	if event.is_action_pressed("previous_weapon"):
		weapon_equipment_component.previous_weapon()
	if event.is_action_pressed("1"):
		weapon_equipment_component.choose_weapon(1)
	if event.is_action_pressed("2"):
		weapon_equipment_component.choose_weapon(2)
	if event.is_action_pressed("3"):
		weapon_equipment_component.choose_weapon(3)

func _process(delta):
	update_animation()
	update_sprite_orientation()

func _physics_process(delta):
	velocity = movement_component.update_velocity(Input, velocity)
	move_and_slide()

func update_sprite_orientation():
	var mouse_direction = global_position - get_global_mouse_position()
	if mouse_direction.x < 0:
		sprite_2d.flip_h = false
	elif mouse_direction.x > 0:
		sprite_2d.flip_h = true

func update_animation():
	if velocity == Vector2.ZERO:
		$AnimationPlayer.play("idle")
	else:
		$AnimationPlayer.play("run")


func die():
	sprite_2d.visible = false
