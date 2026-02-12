extends Node2D

const SPAWNER_Y: float = 3000.0

@export var region_prefab: PackedScene

@onready var spawn_timer: Timer = $SpawnTimer


func _ready() -> void:
	spawn()


func spawn() -> void:
	var new_platform = region_prefab.instantiate()
	new_platform.init_pos()
	add_child(new_platform)
	new_platform.global_position.y = SPAWNER_Y


func _on_spawn_timeout() -> void:
	if GameManager.is_paused:
		return
	spawn()
