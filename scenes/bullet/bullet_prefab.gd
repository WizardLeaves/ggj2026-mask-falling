extends Area2D

const OFFSET_RADIUS: float = deg_to_rad(60)
var fever_speed: float = 1.0

var can_be_reflected: bool = false
var is_reflected: bool = false
var emit_vector: Vector2 = Vector2.ZERO
var emit_speed: float = 300.0
var start_emit: bool = false


func _ready() -> void:
	GameManager.connect("player_state_changed", _on_player_state_changed)
	if !start_emit:
		$WaitTimer.start()


func _physics_process(delta: float) -> void:
	if GameManager.is_paused:
		return
	
	if global_position.x < 0 or global_position.x > 600 or global_position.y < -500 or global_position.y > 1360:
		remove()
	
	if emit_vector.is_zero_approx() == false and start_emit:
		position = position + emit_vector * emit_speed * delta * fever_speed


func check_state(player: Player) -> void:
	if player.get_player_state().player_state == PlayerState.PlayerStates.Normal:
		"""if can_be_reflected:
			reflect_bullet()"""
		GameManager.life_manager.loss_life()
		player._on_player_damaged()
	else:
		if can_be_reflected:
			reflect_bullet()
	#remove()


func reflect_bullet() -> void:
	is_reflected = true
	var new_reflect := - emit_vector
	new_reflect = new_reflect.rotated(- OFFSET_RADIUS / 2.0)
	new_reflect = new_reflect.rotated(OFFSET_RADIUS * randf())
	set_rotate_vertex(new_reflect)
	GameManager.score_manager.add_reflect_score()


func set_rotate_vertex(value: Vector2) -> void:
	# print(rad_to_deg(value.angle()))
	emit_vector = value
	rotation = value.angle()


func set_interval(value: float) -> void:
	if value == 0:
		start_emit = true
	else:
		$WaitTimer.wait_time = value


func set_reflect(can: bool) -> void:
	#print(can)
	can_be_reflected = can


func set_speed(value: float) -> void:
	emit_speed = value


func set_enemy_state(enemy: Enemy) -> void:
	if is_reflected:
		enemy.loss_life()
		remove()


func remove() -> void:
	self.queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		#GameManager.life_manager.loss_life()
		check_state(area)
	elif area.is_in_group("enemy"):
		set_enemy_state(area)


func _on_wait_timer_timeout() -> void:
	start_emit = true


func _on_player_state_changed(value: PlayerState.PlayerStates) -> void:
	if value == PlayerState.PlayerStates.Normal:
		fever_speed = 1.0
	else:
		fever_speed = 2
