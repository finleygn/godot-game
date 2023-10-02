class_name HurtBox
extends Area3D

signal hurt_register(attacking_entity)

func _init() -> void:
	collision_layer = 0;
	collision_mask = 2;

func _ready() -> void:
	area_entered.connect(_on_area_entered);
	
func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox == null:
		return;
	hitbox.on_hurtbox_collide(self);
	hurt_register.emit(hitbox.owner);
