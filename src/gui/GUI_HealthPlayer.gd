extends ColorRect
class_name GuiHealthPlayer

@onready var health_bar = $HealthBar;

var health_pool: HealthPool;
var animated_health: float;

var DamageLabel = preload("res://scenes/DamageLabel.tscn");

func set_health_pool(target_health_pool: HealthPool):
	health_pool = target_health_pool;
	animated_health = float(health_pool.current);
	target_health_pool.health_changed.connect(_on_health_pool_health_changed)

func update_health_bar_size(delta):
	animated_health = lerp(animated_health, float(health_pool.current), 0.05);
	health_bar.scale.x = animated_health / float(health_pool.maximum);

func _on_health_pool_health_changed(current, previous):
	# Create damage 
	var damage_label = DamageLabel.instantiate()
	damage_label.text = "%d" % (current - previous);
	damage_label.movement_vector = Vector2.UP;
	
	# Position damage label
	var half_label_width = damage_label.size.x * 0.5;
	var end_of_health_position = health_bar.size.x * health_bar.scale.x;
	damage_label.position.x = end_of_health_position - half_label_width;
	
	# Start damage label animation (kills self when ended)
	add_child(damage_label)
	damage_label.start()

func _process(delta):
	update_health_bar_size(delta);
