extends Resource
class_name Fungible

signal fungible_changed();

@export var name: String;
@export var quantity: int;
@export var texture: Texture;

func can_withdraw(amt: int) -> bool:
	return amt <= quantity;

func withdraw(amt: int):
	if amt > quantity:
		pass
	quantity -= amt;
	fungible_changed.emit()

func deposit(amt: int):
	quantity += amt;
	fungible_changed.emit()
