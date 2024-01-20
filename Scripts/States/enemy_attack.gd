extends State
class_name EnemyAttack

var current_weapon: BaseWeaponComponent
var enemy: EnemyEntity
var player: CharacterBody2D = null

func Enter():
	current_weapon = enemy.enemy_weapon_equipment_component.current_weapon

func Physics_Update(delta):
	current_weapon.shoot()
	var direction = player.global_position - enemy.global_position
	if direction.length() <= 250:
		Transitioned.emit(self, "follow")
