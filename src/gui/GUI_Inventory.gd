extends PanelContainer
class_name GuiInventory

const GuiFungible = preload("res://src/gui/GUI_Fungible.tscn");

var player_inventory: Inventory;
@onready var grid_container = $MarginContainer/GridContainer

func set_player_inventory(inventory: Inventory):
	player_inventory = inventory;
	populate_fungible(inventory.get_fungible_array())

func populate_fungible(items: Array[Fungible]) -> void:
	for child in grid_container.get_children():
		child.queue_free();
		
	for item in items:
		var gui = GuiFungible.instantiate();
		grid_container.add_child(gui);
		gui.set_fungible(item);

