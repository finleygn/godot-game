class_name VisibleBox
extends InteractableArea

signal observed(by);

func _init() -> void:
	collision_layer = 0;
	collision_mask = 3;

func _on_area_entered(area: Area3D) -> void:
	if area is SightlineBox:
		observed.emit(area.owner);
