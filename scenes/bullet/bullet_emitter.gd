extends Node2D
class_name BulletEmitter

@export var bullet_prefab: PackedScene = preload("res://scenes/bullet/bullet_prefab.tscn")
@export var thorn_prefab: PackedScene = preload("res://scenes/thorn/thorn.tscn")
@export var bullet_interval: float = 0
@export_enum("bullet", "thorn") var bullet_type: int
@export var bullet_can_be_reflected: bool = false
@export var bullet_speed: float = 300.0
@export_enum("pos", "player") var bullet_target_type: int
@export var bullet_target: Vector2
@export var emit_interval: float = 1.0

@onready var emit_timer: Timer = $EmitTimer


func _ready() -> void:
	$EmitTimer.wait_time = emit_interval


func emit_bullet(target: Vector2 = Vector2(0,0)) -> void:
	var new_bullet
	if bullet_type == 0:
		new_bullet = bullet_prefab.instantiate()
	else:
		new_bullet = thorn_prefab.instantiate()
	if bullet_target_type == 1:
		bullet_target = target
	var direct_vector: Vector2 = (bullet_target - position).normalized()
	# print(direct_vector)
	new_bullet.set_rotate_vertex(direct_vector)
	new_bullet.set_interval(bullet_interval)
	new_bullet.set_reflect(bullet_can_be_reflected)
	new_bullet.set_speed(bullet_speed)
	add_child(new_bullet)
