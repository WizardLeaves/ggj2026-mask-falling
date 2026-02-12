extends Control


func _ready() -> void:
	modulate = Color(1, 1, 1, 0)


func die_in() -> void:
	set_info()
	var tween := create_tween()
	tween.tween_property(self, "modulate", modulate+Color(0,0,0,0.9), 1.0)
	await tween.finished
	can_judge()


func can_judge() -> void:
	$Again.disabled = false
	$Back.disabled = false


func set_info() -> void:
	$Score2.text = "%d" % GameManager.score_manager.cur_score
	$Score4.text = "%d" % GameManager.score_manager.enemy_count
	$Score6.text = "%d" % GameManager.score_manager.sans_count



func _on_again_button_down() -> void:
	GameManager.init_game()
	get_tree().change_scene_to_file("res://scenes/main/main_theme.tscn")


func _on_back_button_down() -> void:
	GameManager.init_game()
	get_tree().change_scene_to_file("res://scenes/start/start_menu/start.tscn")
