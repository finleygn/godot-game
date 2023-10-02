extends Camera3D

@export var target: Node3D;
var starting_position_diff: Vector3;

func _ready():
	starting_position_diff = global_position - target.global_position;
	

func _physics_process(delta):
	if(!target):
		return;
	var target_xform = target.global_position - starting_position_diff;
	var lerped_transform = global_position.lerp(target_xform, 20.0 * delta);
	global_position.x = lerped_transform.x;
	global_position.z = lerped_transform.z;
