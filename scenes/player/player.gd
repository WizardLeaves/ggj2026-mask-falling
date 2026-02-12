extends Area2D
class_name Player

@onready var player_state: PlayerState = $PlayerState

const NORMAL_HEIGHT: float = 0
const FEVER_HEIGHT: float = 130

const NORMAL_SPEED: float = 400
const FEVER_SPEED: float = 500

const LIMIT_LEFT: float = 51.2
const LIMIT_RIGHT: float = 548.8

var cur_pos: float
var target_pos: float
var cur_pos_move: float = 0
var pos_move_time: float = 3

var move_speed: float = NORMAL_SPEED
var input_state: bool = true


func _ready() -> void:
	GameManager.life_manager.connect("player_died", _on_player_died)
	init_player()


func init_player() -> void:
	set_state(true)
	set_normal_state()
	cur_pos = NORMAL_HEIGHT
	target_pos = NORMAL_HEIGHT


func _physics_process(delta: float):
	if !input_state or GameManager.is_paused:
		return
	var direct: int = 0
	if Input.is_action_pressed("move_left"):
		direct -= 1
	if Input.is_action_pressed("move_right"):
		direct += 1
	position.x = clamp(position.x + direct * move_speed * delta, LIMIT_LEFT, LIMIT_RIGHT)

	if target_pos != cur_pos:
		if abs(cur_pos - target_pos) < 5:
			cur_pos = target_pos
		else:
			cur_pos_move += delta * pos_move_time
			cur_pos = lerp(cur_pos, target_pos, cur_pos_move)
		position.y = cur_pos

	player_state.check_state_shift()


func set_state(value: bool) -> void:
	if value:
		set_process(true)
		input_state = true
	else:
		set_process(false)
		input_state = false


func get_player_state() -> PlayerState:
	return player_state


func set_player_state(state: PlayerState.PlayerStates) -> void:
	player_state.player_state = state


func set_normal_state() -> void:
	$Normal.show()
	$NormalShape.set_deferred("disabled", false)
	$Fire.hide()
	$Fever.hide()
	$FeverShape.set_deferred("disabled", true)
	move_speed = NORMAL_SPEED
	target_pos = NORMAL_HEIGHT
	$Fire.stop()
	$Fire.hide()


func set_fever_state() -> void:
	$Normal.hide()
	$NormalShape.set_deferred("disabled", true)
	$Fire.show()
	$Fever.show()
	$FeverShape.set_deferred("disabled", false)
	move_speed = FEVER_SPEED
	target_pos = FEVER_HEIGHT
	$Fire.play()
	$Fire.show()


func _on_player_damaged() -> void:
	player_state.can_change = false
	player_state.change_state(PlayerState.PlayerStates.Normal)
	$AnimationPlayer.play("damaged")


func _on_player_died() -> void:
	set_state(false)


func _on_player_state_state_changed(value: PlayerState.PlayerStates) -> void:
	if value == PlayerState.PlayerStates.Normal:
		set_normal_state()
	else:
		set_fever_state()
	cur_pos_move = 0


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "damaged":
		player_state.can_change = true
