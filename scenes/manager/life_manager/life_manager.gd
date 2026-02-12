extends Node
class_name LifeManager
signal life_changed(value: int)
signal player_died


@export var max_life: int = 3
var cur_life: int:
	set(value):
		cur_life = value
		life_changed.emit(value)


func _ready() -> void:
	init_life()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("suicide"):
		if !GameManager.is_dead:
			instant_die()


func init_life() -> void:
	cur_life = max_life


func add_life() -> void:
	cur_life = min(max_life, cur_life + 1)


func loss_life() -> void:
	cur_life -= 1
	# print(cur_life)
	if cur_life <= 0:
		player_died.emit()


func instant_die() -> void:
	# print("die")
	cur_life = 0
	player_died.emit()
