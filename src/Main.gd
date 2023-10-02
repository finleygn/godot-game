extends Node3D

@onready var gui_inventory: GuiInventory = $GUI/Inventory
@onready var gui_player_health_pool: GuiHealthPlayer = $GUI/HealthPlayer
@onready var player = $Player

func _ready() -> void:
	gui_inventory.set_player_inventory(player.inventory)
	gui_player_health_pool.set_health_pool(player.health_pool)
