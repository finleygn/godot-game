class_name SpawnableRock
extends Spawnable

func initialize(start_position):
	super(start_position)
	rotation = Vector3(
		randf_range(0, PI),
		randf_range(0, PI),
		randf_range(0, PI),
	)
	scale = Vector3(
		randf_range(1, PI),
		randf_range(1, PI),
		randf_range(1, PI),
	)

func _on_hurt_box_hurt_register(attacking_entity):
	if attacking_entity is Player:
		attacking_entity.inventory.stone_account.deposit(1);
		resources_available -= 1;
		$AnimationPlayer.play("hurt_and_small");
