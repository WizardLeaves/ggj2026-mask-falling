extends Node2D

const RANDOM_OFFSET_RANGE: float = 50.0

@onready var thorn: Area2D = $Thorn

@export var is_random: bool = true


func _ready() -> void:
	if is_random:
		init_thorn()


func init_thorn() -> void:
	thorn.position.x += randf() * RANDOM_OFFSET_RANGE


func _on_platform_breaked() -> void:
	queue_free()


func _on_thorn_breaked() -> void:
	queue_free()
