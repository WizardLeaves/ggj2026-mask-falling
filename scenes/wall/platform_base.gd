extends Area2D
signal platform_breaked

var offset: float = 5.0
var cur_index: int = 1

func init_pos() -> void:
	position.x = 60 + 480.0 * randf()


func check_state(player: Player) -> void:
	if player.get_player_state().player_state == PlayerState.PlayerStates.Normal:
		if !check_pos(player):
			GameManager.life_manager.instant_die()
	else:
		if !check_pos(player):
			platform_break()
			GameManager.score_manager.add_break_score()


func check_pos(area: Player) -> bool:
	#print(self.global_position.y - area.global_position.y - GameManager.PLAYER_HEIGHT / 2.0)
	if global_position.y - area.global_position.y - GameManager.PLAYER_HEIGHT / 2.0 < offset:
		#print("蹭一下")          
		return true
	"""else:
		GameManager.life_manager.instant_die()
		#print("死！")"""
	return false


func platform_break() -> void:
	platform_breaked.emit()
	self.queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		check_state(area)
	elif area.is_in_group("boss"):
		platform_break()
