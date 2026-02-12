extends Node2D


func _ready() -> void:
	DisplayServer.window_set_size(Vector2i(450, 1020))
	DisplayServer.window_get_size()
	#$EnemyEmitter.emit_bullet()


func _on_timer_timeout() -> void:
	$Type1.shoot()
	$Type2.shoot()
