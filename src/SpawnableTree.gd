class_name SpawnableTree
extends Spawnable

func initialize(start_position):
	super(start_position)
	rotation = Vector3(
		rotation.x,
		randf_range(0, PI),
		0,
	)
	var scale_size = randf_range(1, 1.4);
	scale = Vector3(
		scale_size,
		scale_size,
		scale_size,
	)

func _on_hurt_box_hurt_register(attacking_entity):
	if attacking_entity is Player:
		attacking_entity.inventory.wood_account.deposit(1);
		resources_available -= 1;
		$AnimationPlayer.play("hurt_and_small");
