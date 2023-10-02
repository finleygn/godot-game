class_name HitBox
extends Area3D

signal hit_register(attacked_entity)

func _init() -> void:
	collision_layer = 2

func on_hurtbox_collide(hurtbox: HurtBox) -> void:
	print_debug(hurtbox.owner)
	hit_register.emit(hurtbox.owner)

func enable():
	for child in get_children():
		if child is CollisionShape3D:
			child.disabled = false;

func disable():
	for child in get_children():
		if child is CollisionShape3D:
			child.disabled = true;
