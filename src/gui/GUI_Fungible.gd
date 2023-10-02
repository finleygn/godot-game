extends PanelContainer
class_name GuiFungible

@onready var quantity_label = $MarginContainer/GridContainer/MarginContainer/QuantityLabel
@onready var texture_rect = $MarginContainer/GridContainer/TextureRect

var fungible: Fungible;

func set_fungible(target_fungible: Fungible):
	fungible = target_fungible;
	texture_rect.texture = fungible.texture;
	fungible.fungible_changed.connect(update_ui);
	update_ui();

func update_ui():
	quantity_label.text = "%d" % fungible.quantity;
