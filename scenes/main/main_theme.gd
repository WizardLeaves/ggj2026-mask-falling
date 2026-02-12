extends Node2D

const NORMAL_SPEED: float = 500
const FEVER_SPEED: float = 800

@onready var player: Player = $Player
@onready var music_player: MusicPlayer = $MusicPlayer
@onready var camera: Camera2D = $Camera2D
@onready var environment: Envir = $Environment
@onready var die_hud: Control = $UI/DieHud


## 相机距离玩家的位置
var camera_offset: float = GameManager.NORMAL_HEIGHT_OFFSET
var target_offset: float = GameManager.NORMAL_HEIGHT_OFFSET
var move_speed: float = 0.8
var cur_move: float = 0


func _ready() -> void:
	GameManager.connect("player_state_changed", _on_player_state_changed)
	GameManager.life_manager.connect("player_died", _on_player_died)
	GameManager.connect("paused", _on_game_paused)
	init_data()
	GameManager.is_started = false


func _physics_process(_delta: float) -> void:
	# fixed_camera(delta)
	pass


func init_data() -> void:
	init_camera()
	init_music()


func init_music() -> void:
	if GameManager.loaded_music_path != null:
		music_player.load_stream_from_file_path(GameManager.loaded_music_path, GameManager.loaded_music_type)
	music_player.play()


func init_camera() -> void:
	camera_offset = GameManager.NORMAL_HEIGHT_OFFSET
	target_offset = GameManager.NORMAL_HEIGHT_OFFSET
	var player_y: float = player.position.y
	camera.position.y = player_y + camera_offset


func fixed_camera(delta: float) -> void:
	if camera_offset != target_offset:
		if abs(camera_offset - target_offset) < 5:
			camera_offset = target_offset
		else:
			cur_move += delta * move_speed
			camera_offset = lerp(camera_offset, target_offset, cur_move)
	
	var player_y: float = player.position.y
	camera.position.y = player_y + camera_offset


func _on_player_died() -> void:
	environment.set_speed_die()
	die_hud.die_in()
	$CanvasLayer/ParallaxBackground.autoscroll.y = 0


func _on_player_state_changed(value: PlayerState.PlayerStates) -> void:
	if value == PlayerState.PlayerStates.Normal:
		target_offset = GameManager.NORMAL_HEIGHT_OFFSET
		$CanvasLayer/ParallaxBackground.autoscroll.y = -NORMAL_SPEED
	else:
		target_offset = GameManager.FEVER_HEIGHT_OFFSET
		$CanvasLayer/ParallaxBackground.autoscroll.y = -FEVER_SPEED
	cur_move = 0


func _on_game_paused(value: bool) -> void:
	if value:
		$CanvasLayer/ParallaxBackground.autoscroll.y = 0
		player.set_player_state(PlayerState.PlayerStates.Normal)
	else:
		$CanvasLayer/ParallaxBackground.autoscroll.y = -NORMAL_SPEED
