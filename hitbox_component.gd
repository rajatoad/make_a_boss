extends Area2D
class_name HitboxComponent

signal hit_trigger

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("Bullet"):
		hit_trigger.emit(area.damage)
		area.queue_free()
