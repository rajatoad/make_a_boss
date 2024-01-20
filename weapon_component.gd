extends BaseWeaponComponent
class_name WeaponComponent

#@export var shooting_type: String = "SINGLE"

func _physics_process(delta):
	animate_weapon()

func animate_weapon():
	look_at(get_global_mouse_position())
	if get_global_mouse_position().x > global_position.x:
		sprite_2d.flip_v = false
	else:
		sprite_2d.flip_v = true

func shoot():
	if not is_shooting:
		create_bullet(Vector2.ZERO)
			#"RIFLE":
				#create_bullet(Vector2.ZERO)
			#"SHOTGUN":
				#create_bullet(Vector2(20, 20))
				#create_bullet(Vector2(40, 40))
				#create_bullet(Vector2.ZERO)
				#create_bullet(Vector2(-20, -20))
				#create_bullet(Vector2(-40, -40))

func create_bullet(angle: Vector2):
	is_shooting = true
	var bullet_instance = BULLET.instantiate()
	bullet_instance.shoot(
			marker_2d.global_position, 
			get_global_mouse_position() + angle, 
			bullet_speed
		)
	bullet_instance.set_collision_layer_value(layer, true)
	get_tree().root.add_child(bullet_instance)
	timer.start(weapon_shoot_time)

func _on_timer_timeout():
	is_shooting = false
