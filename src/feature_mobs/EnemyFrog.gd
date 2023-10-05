class_name EnemyFrog
extends CharacterBody3D

@export var movement_speed: float = 4.0;
@export var health_pool: HealthPool;

@onready var animation_player = $fog/AnimationPlayer;
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D;
@onready var floating_health_bar = $FloatingHealthBar;

const AGGRO_RANGE = 10.0;
const JUMP_INTERVAL = 0.2;

enum ENEMY_STATES {
	WANDERING,
	ATTACKING,
	JUMPING,
	AGGRO
}

var target: Node3D = null;
var current_state = ENEMY_STATES.WANDERING;
var queued_jump = false;

# So movement with a frog isnt consistent
# We need to play the animation, while playing move, pause for a second, and the jump again

func _ready():
	navigation_agent.path_desired_distance = 0.5
	navigation_agent.target_desired_distance = 0.5
	
	floating_health_bar.set_health_pool(health_pool)
	health_pool.health_exhausted.connect(_on_health_pool_health_exhausted);
	animation_player.animation_finished.connect(_on_animation_finished);

func queue_jump() -> void:
	if !queued_jump:
		queued_jump = true
		get_tree().create_timer(JUMP_INTERVAL, false).timeout.connect(transition_to_jumping);

func transition_to_aggro(_target = null) -> void:
	if _target:
		target = _target;
	current_state = ENEMY_STATES.AGGRO;

func transition_to_wandering():
	target = null;
	current_state = ENEMY_STATES.WANDERING;

func transition_to_jumping() -> void:
	current_state = ENEMY_STATES.JUMPING;
	queued_jump = null;
	animation_player.play("Walk");

func _on_animation_finished(animation_name):
	if(animation_name == "Walk"):
		transition_to_aggro();

func _on_sightline_area_entered(entered_entity):
	if entered_entity.owner is Player:
		transition_to_aggro(entered_entity.owner)

func _physics_process(delta):
	if current_state == ENEMY_STATES.AGGRO && target:
		if target.position.distance_to(position) < AGGRO_RANGE:
			navigation_agent.set_target_position(target.position);
			queue_jump()
			look_at(target.position);
		else:
			transition_to_wandering();

	if current_state == ENEMY_STATES.JUMPING:
		var current_agent_position: Vector3 = global_position
		var next_path_position: Vector3 = navigation_agent.get_next_path_position()

		var new_velocity: Vector3 = next_path_position - current_agent_position
		new_velocity = new_velocity.normalized()
		new_velocity = new_velocity * movement_speed

		velocity = new_velocity
		
		move_and_slide()
	else:
		velocity = Vector3.ZERO

func _on_hurt_box_hurt_register(attacking_entity):
	if(attacking_entity is Player):
		health_pool.lose_heath(5);
		transition_to_aggro(attacking_entity)


func _on_health_pool_health_exhausted():
	queue_free()
