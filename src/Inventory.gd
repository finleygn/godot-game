extends Resource
class_name Inventory

var Fungible = preload("res://src/resource_type/Fungible.gd");

@export var gold_account: Fungible;
@export var wood_account: Fungible;
@export var stone_account: Fungible;

func get_fungible_array() -> Array[Fungible]:
	return [
		gold_account,
		wood_account,
		stone_account
	]
