extends Area2D
class_name Boss
signal boss_died

var cur_life: int = 20

func _ready() -> void:
	set_life_bar()

 
func set_life_bar() -> void:
	# print(cur_life)
	$BossLifeBar.value = cur_life


func loss_life() -> void:
	cur_life = max(0, cur_life - 1)
	set_life_bar()
	if cur_life == 0:
		boss_died.emit()


func move_in_anime() -> void:
	pass
