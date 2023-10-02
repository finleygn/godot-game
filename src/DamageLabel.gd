class_name DamageLabel
extends Label

# Time until the label destroys itself
@export var ttl: float =  1.0;

# Direction for the label to move in once spawned
@export var movement_vector: Vector2 = Vector2.UP;

# Variance in the angle of tween
@export var movement_variance: float = PI * 0.1;

# Speed for the label to move
@export var movement_magnitude: float = 50.0;

# Variance in the magnitude of tween
@export var magnitude_variance: float = 20.0;

func start():
	var tween = get_tree().create_tween()
	
	tween.tween_property(
		self, 
		"position", 
		position 
			+ movement_vector.rotated(
				movement_variance * 
				randf_range(-1.0, 1.0)
			)
			* (movement_magnitude + magnitude_variance * randf_range(-1.0, 1.0)),
		0.5
	).set_ease(tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC);
	
	tween.parallel();
	
	tween.tween_property(
		self, 
		"modulate", 
		Color(modulate.r, modulate.g, modulate.b, 0),
		1
	).set_trans(Tween.TRANS_EXPO)
	
	tween.tween_callback(queue_free)

