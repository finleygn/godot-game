class_name SightlineBox
extends InteractableArea

signal seen_entity(seen);

func _init() -> void:
	collision_layer = 3;

func _on_area_entered(area: Area3D) -> void:
	if area is VisibleBox:
		seen_entity.emit(area.owner);
