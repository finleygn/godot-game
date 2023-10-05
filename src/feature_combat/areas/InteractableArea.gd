class_name InteractableArea
extends Area3D

func _ready() -> void:
	area_entered.connect(_on_area_entered);

func _on_area_entered(_area: Area3D) -> void:
	pass;

func enable():
	for child in get_children():
		if child is CollisionShape3D:
			child.disabled = false;

func disable():
	for child in get_children():
		if child is CollisionShape3D:
			child.disabled = true;
