class_name Player
extends CharacterBody3D

const ATTACK_TIMER = 0.1;

@onready var node_attack_timer = $Timer
@onready var node_hit_box = $HitBox

@export var speed = 14
@export var inventory: Inventory  = Inventory.new();
@export var health_pool: HealthPool= HealthPool.new();

var velocity_modifier = 0
var current_direction = Vector3.FORWARD
var input_direction = Vector3.FORWARD
var attacking = false
	

func _ready():
	$DebugOverlay.draw.add_vector(self, "input_direction", 1, 4, Color(0,1,0, 0.5))
	$DebugOverlay.draw.add_vector(self, "current_direction", 1, 4, Color(0,1,1.0, 0.4))
	$DebugOverlay.draw.add_vector(self, "velocity", 1, 4, Color(1.0,0.0,1.0, 0.4))
	node_hit_box.disable();
	node_attack_timer.timeout.connect(_on_attack_timer_ended);

func _physics_process(delta):
	look_at_mouse();
	handle_movement(delta);
	
	if Input.is_action_pressed('attack'):
		handle_attack();

# Attacking -----

func _on_hit_box_hit_register(_attacked_entity):
	pass


func handle_attack():
	if attacking:
		return;
	attacking = true;
	
	$PlayerModel/AnimationTree.set(
		"parameters/attack_shot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE,
	);
	node_hit_box.enable();
	node_attack_timer.start(ATTACK_TIMER);

func _on_player_model_attack_animation_finished():
	attacking = false;

func _on_attack_timer_ended():
	node_hit_box.disable();
	

# Movement -----

func handle_movement(delta: float):
	var temp_target_direction = Vector3.ZERO
	var movement_active = false;
	
	if Input.is_action_pressed("move_right"):
		temp_target_direction.x += 1
		movement_active = true
	if Input.is_action_pressed("move_left"):
		temp_target_direction.x -= 1
		movement_active = true
	if Input.is_action_pressed("move_down"):
		temp_target_direction.z += 1
		movement_active = true
	if Input.is_action_pressed("move_up"):
		temp_target_direction.z -= 1
		movement_active = true
	
	if(temp_target_direction.length() > 0.1):
		input_direction = temp_target_direction.normalized()
		
	if movement_active:
		current_direction = current_direction.lerp(input_direction, 0.1)
		velocity_modifier = lerpf(velocity_modifier, speed, 0.4)
	else:
		current_direction = Vector3.ZERO
		velocity_modifier = lerpf(velocity_modifier, 0, 0.3)


	if(velocity_modifier < 0.9):
		$PlayerModel/AnimationTree.set(
			"parameters/walk_idle_blend/blend_amount",
			max($PlayerModel/AnimationTree.get("parameters/walk_idle_blend/blend_amount") - (5.0 * delta), 0.0)
		)
	else:
		$PlayerModel/AnimationTree.set("parameters/walk_idle_blend/blend_amount", 
			min($PlayerModel/AnimationTree.get("parameters/walk_idle_blend/blend_amount") + (5.0 * delta), 1.0)
		)

	velocity = current_direction * velocity_modifier
	move_and_slide()

func look_at_mouse():
	var position2D = get_viewport().get_mouse_position()
	var dropPlane  = Plane(0.0, 1.0, 0.0, 0.0)
	
	var position3D = dropPlane.intersects_ray(
		get_viewport().get_camera_3d().project_ray_origin(position2D),
		get_viewport().get_camera_3d().project_ray_normal(position2D)
	)
	
	if position3D:
		look_at(Vector3(
			position3D.x,
			position.y,
			position3D.z
		))


