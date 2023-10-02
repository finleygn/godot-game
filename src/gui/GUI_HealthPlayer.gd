extends PanelContainer
class_name GuiHealthPlayer

@onready var quantity_label = $QuantityLabel

var health_pool: HealthPool;

func set_health_pool(target_health_pool: HealthPool):
	health_pool = target_health_pool;
	health_pool.health_changed.connect(update_ui);

func update_ui(current, previous):
	quantity_label.text = "%d" % [current];
	print_debug("Recieved update")
	pass;
