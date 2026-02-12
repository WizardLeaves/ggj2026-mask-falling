extends Node
class_name ScoreManager

var cur_score: float = 0
var life_score: float = 100.0
var break_score: float = 200.0
var reflect_score: float = 0.0
var is_dead: bool = false
 
var enemy_count: int = 0
var sans_count: float = 0


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	if !is_dead and !GameManager.is_paused:
		cur_score += life_score * delta


func init_score() -> void:
	cur_score = 0
	is_dead = false
	enemy_count = 0
	sans_count = 0


func add_enemy_count() -> void:
	enemy_count += 1
	cur_score += 1000.0


func add_sans_count(add: float) -> void:
	sans_count += add


func add_break_score() -> void:
	cur_score += break_score


func add_reflect_score() -> void:
	cur_score += reflect_score


func _on_player_died() -> void:
	is_dead = true
