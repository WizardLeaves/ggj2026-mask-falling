extends Node
class_name PlayerState
signal state_changed(value: PlayerStates)

enum PlayerStates {
	Normal, Fever
} 

var player_state: PlayerStates
var can_change: bool = true


func _ready() -> void:
	init_state()


func init_state() -> void:
	player_state = PlayerStates.Normal


func change_state(value: PlayerStates) -> void:
	player_state = value
	state_changed.emit(player_state)


func check_state_shift() -> void:
	"""if Input.is_action_just_pressed("shift_mask") and can_change:
		if player_state == PlayerStates.Normal:
			player_state = PlayerStates.Fever
		else:
			player_state = PlayerStates.Normal
		state_changed.emit(player_state)
		GameManager.set_state(player_state)"""
	if can_change:
		if Input.is_action_pressed("shift_mask", false):
			player_state = PlayerStates.Fever
			state_changed.emit(player_state)
			GameManager.set_state(player_state)
		elif player_state == PlayerStates.Fever:
			player_state = PlayerStates.Normal
			state_changed.emit(player_state)
			GameManager.set_state(player_state)
