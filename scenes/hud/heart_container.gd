extends TextureRect

func _ready() -> void:
	GameManager.life_manager.connect("life_changed", _on_life_changed)


func _on_life_changed(life: int) -> void:
	if life > 0:
		$Heart.show()
	else:
		$Heart.hide()
	
	if life > 1:
		$Heart2.show()
	else:
		$Heart2.hide()
	
	if life > 2:
		$Heart3.show()
	else:
		$Heart3.hide()
