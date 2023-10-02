class_name HealthPool
extends Resource

@export var maximum: int;
@export var current: int;

signal health_exhausted();
signal health_changed(value: int, previous: int);

func lose_heath(amount):
	update_health(max(0, current - amount))

func gain_health(amount):
	update_health(min(maximum, current + amount))

func update_health(health):
	var temp_current = current;
	current = health;
	
	# health did change
	if temp_current != health:
		health_changed.emit(current, temp_current)
	
	if current == 0:
		health_exhausted.emit()
