extends Node3D

signal attack_animation_finished()

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "Attack":
		attack_animation_finished.emit()
