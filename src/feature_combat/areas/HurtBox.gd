class_name HurtBox
extends InteractableArea

signal hurt_register(attacking_entity);

func _init() -> void:
	collision_layer = 0;
	collision_mask = 2;

func _on_area_entered(area: Area3D) -> void:
	if(area is HitBox):
		hurt_register.emit(area.owner);	
