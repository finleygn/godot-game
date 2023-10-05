extends Node3D

@export var health_pool: HealthPool;
@onready var health_bar = $SubViewport/HealthBar;

var DamageLabel = preload("res://scenes/DamageLabel.tscn");

func set_health_pool(_health_pool: HealthPool) -> void:
	health_pool = _health_pool;
	health_pool.health_changed.connect(_on_health_pool_update);
	
func _on_health_pool_update(current, previous):
	print_debug(health_pool.get_percent())
	health_bar.value = health_pool.get_percent() * 100;
	
	# Create damage 
	var damage_label = DamageLabel.instantiate()
	damage_label.text = "%d" % (current - previous);
	damage_label.movement_vector = Vector2.UP;
	damage_label.movement_variance = PI;
	
	# Position damage label
	var half_label_width = damage_label.size.x * 0.5;
	var end_of_health_position = health_bar.size.x * (health_bar.value / 100);
	damage_label.position.x = end_of_health_position - half_label_width;
	
	# Start damage label animation (kills self when ended)
	health_bar.add_child(damage_label)
	damage_label.start()
