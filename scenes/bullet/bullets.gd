extends Node2D

var is_20_shooted: bool = false
var is_25_shooted: bool = false

var jiange: float = 3.0
var step: int = 6
var start_1: float = 0
var index_1: int = step
var start_2: float = 2
var index_2: int = step
var enemy_step: int = 10
var enemy_index: int = 3
var enemy_jiange: float = 10


func _physics_process(_delta: float) -> void:
	if !is_20_shooted:
		if GameManager.cur_time > 20:
			is_20_shooted = true
			$Emitter/Type1.shoot() 
	
	if !is_25_shooted:
		if GameManager.cur_time > 25:
			is_25_shooted = true
			$Emitter/Type2.shoot()
	
	if start_1 + index_1 * jiange < GameManager.cur_time:
		index_1 += 1
		var jilv: float = randf()
		if jilv > 0.2:
			$Emitter/Type1.shoot() 
	
	if start_2 + index_2 * jiange < GameManager.cur_time:
		index_2 += 1
		var jilv: float = randf()
		if jilv > 0.2:
			$Emitter/Type2.shoot() 
	
	if enemy_index * enemy_jiange < GameManager.cur_time:
		enemy_index += 1
		print(enemy_index)
		$EnemyEmitter.emit_bullet()
		
