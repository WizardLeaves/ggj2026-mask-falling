extends Node
class_name MusicPlayer

const FEVER_PLAY_SCALE: float = 2.0

@onready var player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	GameManager.connect("player_state_changed", _on_player_state_changed)
	GameManager.life_manager.connect("player_died", _on_player_died)


func set_stream(datas: PackedByteArray, type: int) -> void:
	var new_stream
	if type == 0:
		new_stream = AudioStreamMP3.load_from_buffer(datas)
	else:
		new_stream = AudioStreamOggVorbis.load_from_buffer(datas)
	player.stream = new_stream


func load_stream_from_file_path(path: String, type: int) -> void:
	if FileAccess.file_exists(path):
		var datas: PackedByteArray = FileAccess.get_file_as_bytes(path)
		set_stream(datas, type)


func play() -> void:
	player.play()


func stop() -> void:
	player.stop()


func set_play_scale(value: float) -> void:
	player.pitch_scale = value


func _on_player_state_changed(value: PlayerState.PlayerStates) -> void:
	if value == PlayerState.PlayerStates.Normal:
		set_play_scale(1.0)
	else:
		set_play_scale(FEVER_PLAY_SCALE)


func _on_player_died() -> void:
	set_play_scale(FEVER_PLAY_SCALE)
