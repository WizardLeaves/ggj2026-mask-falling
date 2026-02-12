extends Node2D
class_name EnemyEmitter

@export var enemy_prefab: PackedScene = preload("res://scenes/boss/enemy.tscn")
@export var bullet_interval: float = 0
@export var bullet_speed: float = 300.0
@export var bullet_target: Vector2
@export var emit_interval: float = 1.0

@onready var emit_timer: Timer = $EmitTimer 


func _ready() -> void:
	$EmitTimer.wait_time = emit_interval


func emit_bullet(has_face: bool = true) -> void:
	var new_bullet = enemy_prefab.instantiate()
	var direct_vector: Vector2 = (bullet_target - position).normalized()
	#print(direct_vector)
	new_bullet.set_rotate_vertex(direct_vector)
	new_bullet.set_interval(bullet_interval)
	new_bullet.set_speed(bullet_speed)
	new_bullet.target_pos = bullet_target
	new_bullet.random_head = has_face
	add_child(new_bullet)
