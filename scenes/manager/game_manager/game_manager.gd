extends Node
signal player_state_changed(value: PlayerState.PlayerStates)
signal bullet_stage_started
signal boss_stage_started
signal paused(value: bool)

@onready var energy_manager: EnergyManager = $EnergyManager
@onready var life_manager: LifeManager = $LifeManager
@onready var score_manager: ScoreManager = $ScoreManager

const NORMAL_HEIGHT_OFFSET = 370.0
const FEVER_HEIGHT_OFFSET = 250.0

var is_viewport: bool = false

var debug_mode: bool = false
var PLAYER_HEIGHT: float = 128.0

var loaded_music_path: String
var loaded_music_type: int = 0

var is_dead: bool = false
var is_paused: bool = false
var is_started: bool = false

var song_name: String = "Default"
var cur_time: float = 0.0


func _ready() -> void:
	DisplayServer.window_set_size(Vector2i(600, 1360))
	DisplayServer.window_get_size()


func set_state(value: PlayerState.PlayerStates) -> void:
	player_state_changed.emit(value)


func init_game() -> void:
	is_dead = false
	is_paused = false
	cur_time = 0
	$EnergyManager.init_mp()
	$LifeManager.init_life()
	$ScoreManager.init_score()
	init_timer()


func init_timer() -> void:
	$BulletTimer.start()
	$BossTimer.start()


func _physics_process(delta: float) -> void:
	if is_started and !is_paused and !is_dead:
		cur_time += delta
		#print("%.2f" % cur_time)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_mode"):
		debug_mode = !debug_mode
		print("debug mode:" + str(debug_mode))
	if event.is_action_pressed("quit"):
		get_tree().quit()
	if event.is_action_pressed("pause"):
		is_paused = !is_paused
		paused.emit(is_paused)
		print("游戏暂停状态: " + str(is_paused))
	if event.is_action_pressed("shift_viewport"):
		if is_viewport:
			DisplayServer.window_set_size(Vector2i(600, 1360))
			DisplayServer.window_get_size()
		else:
			DisplayServer.window_set_size(Vector2i(450, 1020))
			DisplayServer.window_get_size()
		is_viewport = !is_viewport


func restart() -> void:
	init_game()
	get_tree().change_scene_to_file("res://scenes/start/start_menu/start.tscn")


func _on_bullet_timer_timeout() -> void:
	bullet_stage_started.emit()


func _on_boss_timer_timeout() -> void:
	boss_stage_started.emit()


func _on_player_died() -> void:
	is_dead = true
