extends Node3D

@export var world_size: Vector2;
@export var entity_count: int;
@export var scene: PackedScene;
@export var rng_seed: String = "lmfao";

var rng = RandomNumberGenerator.new()

func _ready():
	rng.seed = hash(rng_seed)

	for i in range(entity_count):
		var entity = scene.instantiate()
		var entity_position = global_position;
		
		# TODO: Prevent collisions
		entity.initialize(
			entity_position + Vector3(
				rng.randf_range(-world_size.x, world_size.x),
				0,
				rng.randf_range(-world_size.y, world_size.y)
			)
		)
		
		add_child(entity)
