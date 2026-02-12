extends Area2D
class_name Enemy
signal enemy_died

@export var enemy_life: int = 1
@export var target_pos: Vector2
@export var head_list: Array[Texture2D] = []
@export var random_head: bool = false
var move_type: int = 0
var emit_vector: Vector2 = Vector2.ZERO
var emit_speed: float = 300.0
var start_emit: bool = false
var fever_speed: float = 1.0
var is_waiting: bool = false


func _ready() -> void:
	GameManager.connect("player_state_changed", _on_player_state_changed)
	if random_head:
		set_random_head()
	else:
		$Icon.hide()
	
	if !start_emit:
		$EmitTimer.start()


func _physics_process(delta: float) -> void:
	if GameManager.is_paused:
		return
	
	if is_waiting == false:
		if emit_vector.is_zero_approx() == false and start_emit:
			position = position + emit_vector * emit_speed * delta * fever_speed
			# print(global_position.distance_to(target_pos))
			if global_position.distance_to(target_pos) < 10:
				global_position = target_pos
				is_waiting = true
				$WaitTimer.start()


func kill_enemy() -> void:
	GameManager.score_manager.add_enemy_count()
	enemy_died.emit()
	queue_free()


func loss_life() -> void:
	enemy_life = max(0, enemy_life - 1)
	if enemy_life == 0:
		kill_enemy()


func set_random_head() -> void:
	$Icon.texture = head_list.pick_random()


func set_rotate_vertex(value: Vector2) -> void:
	# print(rad_to_deg(value.angle()))
	emit_vector = value


func set_interval(value: float) -> void:
	if value == 0:
		start_emit = true
	else:
		$WaitTimer.wait_time = value


func set_speed(value: float) -> void:
	emit_speed = value


func find_next_target() -> void:
	target_pos = Vector2(150.0 + 250 * randf(), target_pos.y)
	set_rotate_vertex((target_pos - global_position).normalized())


func _on_player_state_changed(value: PlayerState.PlayerStates) -> void:
	if value == PlayerState.PlayerStates.Normal:
		fever_speed = 1.0
	else:
		fever_speed = 2


func _on_wait_timer_timeout() -> void:
	# print(global_position.y)
	start_emit = false
	find_next_target()
	is_waiting = false
	start_emit = true


func _on_emit_timer_timeout() -> void:
	start_emit = true
