extends Control

@onready var file_loader: FileDialog = $FileDialog

var is_viewport: bool = false


func _ready() -> void:
	GameManager.is_started = false
	# set_viewport()
	set_title(GameManager.song_name)
	GameManager.init_game()


func set_viewport() -> void:
	DisplayServer.window_set_size(Vector2i(450, 1020))
	DisplayServer.window_get_size()
	


func set_title(title: String) -> void:
	$LoadMusic/MusicDisplayTitle.text = title


func _on_load_music_button_down() -> void:
	file_loader.show()


func _on_begin_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/main/main_theme.tscn")


func _on_file_selected(path: String) -> void:
	if FileAccess.file_exists(path) and (path.ends_with(".mp3") or path.ends_with(".ogg")):
		GameManager.loaded_music_path = path
		GameManager.song_name = path.get_file()
		set_title(GameManager.song_name)
		if path.ends_with(".mp3"):
			GameManager.loaded_music_type = 0
		else:
			GameManager.loaded_music_type = 1
