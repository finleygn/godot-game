class_name HitBox
extends InteractableArea

signal hit_register(attacked_entity)

func _init() -> void:
	collision_layer = 2;

func _on_area_entered(area: Area3D) -> void:
	if area is HurtBox:
		hit_register.emit(area.owner)
