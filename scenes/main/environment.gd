extends Node2D
class_name Envir

const NORMAL_SPEED: float = 500
const FEVER_SPEED: float = 800

@onready var platform_spawner: Node2D = $PlatformSpawner

var target_speed: float = NORMAL_SPEED
var cur_speed: float = NORMAL_SPEED

var move_speed: float = 0.8
var cur_move: float = 0


func _ready() -> void:
	GameManager.connect("player_state_changed", _on_player_state_changed)
	GameManager.life_manager.connect("player_died", _on_player_died)
	init_environment()


func _physics_process(delta: float) -> void:
	if GameManager.is_paused:
		return
	set_speed(delta)
	position.y -= delta * cur_speed


func init_environment() -> void:
	init_speed()
	set_physics_process(true)
 

func init_speed() -> void:
	target_speed = NORMAL_SPEED
	cur_speed = NORMAL_SPEED


func set_speed(delta: float) -> void:
	if cur_speed != target_speed:
		if abs(cur_speed - target_speed) < 5:
			cur_speed = target_speed
		else:
			cur_move += delta * move_speed
			cur_speed = lerp(cur_speed, target_speed, cur_move)


func set_speed_die() -> void:
	cur_speed = 0
	target_speed = 0


func _on_player_state_changed(value: PlayerState.PlayerStates) -> void:
	if value == PlayerState.PlayerStates.Normal:
		target_speed = NORMAL_SPEED
	else:
		target_speed = FEVER_SPEED
	cur_move = 0


func _on_player_died() -> void:
	set_physics_process(false)
