extends Control

@onready var sans_bar: TextureProgressBar = $BG/SansBar
@onready var energy_bar: TextureProgressBar = $BG/EnergyBar
@onready var score_bar: Label = $BG/Score


func _ready() -> void:
	pass


func _physics_process(_delta: float) -> void:
	if GameManager.is_paused:
		return
	sans_bar.value = GameManager.energy_manager.cur_sans
	energy_bar.value = GameManager.energy_manager.cur_sans + GameManager.energy_manager.cur_energy
	score_bar.text = "%d" % GameManager.score_manager.cur_score
