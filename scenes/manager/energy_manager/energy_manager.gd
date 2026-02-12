extends Node
class_name EnergyManager
signal sans_zero

const MAX_SANS: float = 40.0
const MAX_ENERGY: float = 60.0
const MAX_MP: float = 100.0

var cur_recover_mode: bool = true

var cur_sans: float = 0
var cur_energy: float = 0
var cur_mp: float:
	get():
		return cur_sans + cur_energy

var recover_speed: float = 10.0
var energy_speed: float = 20.0


func _ready() -> void:
	GameManager.connect("player_state_changed", _on_player_state_changed)
	init_mp()


func _physics_process(delta: float) -> void:
	if !GameManager.is_paused:
		charge_mp(delta)


func init_mp() -> void:
	set_physics_process(true)
	cur_sans = MAX_SANS
	cur_energy = MAX_ENERGY
	cur_recover_mode = true


func set_recover_speed(value: float) -> void:
	recover_speed = value


func charge_mp(delta: float) -> void:
	#print(cur_mp)
	if cur_recover_mode:
		recover_mp(delta)
	else:
		loss_mp(delta)


func recover_mp(delta: float) -> void:
	if cur_sans < MAX_SANS:
		cur_sans = min(MAX_SANS, cur_sans + delta * recover_speed)
	else:
		cur_energy = min(MAX_ENERGY, cur_energy + delta * recover_speed)


func loss_mp(delta: float) -> void:
	if cur_energy > 0:
		cur_energy = max(0, cur_energy - delta * energy_speed)
	else:
		var delta_energy: float = delta * energy_speed
		cur_sans = max(0, cur_sans - delta * energy_speed)
		GameManager.score_manager.add_sans_count(delta_energy)
		if cur_sans < 0:
			cur_sans = 0
			sans_zero.emit()
		if cur_sans == 0 and !GameManager.debug_mode:
			GameManager.life_manager.instant_die()


func _on_player_died() -> void:
	# cur_sans = 0
	# cur_energy = 0
	set_physics_process(false)


func _on_player_state_changed(value: PlayerState.PlayerStates) -> void:
	if value == PlayerState.PlayerStates.Normal:
		cur_recover_mode = true
	else:
		cur_recover_mode = false
