extends Node2D

enum phases {SHOOTING, PLAYER_ATTACK}
var current_phase = null
@onready var phase_timer_node = $PhaseTimer
@onready var boss_node = $Boss
@onready var progress_bar_node = $TextureProgressBar
@onready var target_progress_bar = $TargetTextureProgressBar
var boss_phase_time = 3
var player_attack_phase_time = 3
var target_time = 1

func _ready():
	progress_bar_node.max_value = player_attack_phase_time
	current_phase = phases.SHOOTING
	progress_bar_node.value = 0
	phase_timer_node.start(player_attack_phase_time)
	
func _process(delta):
	if current_phase == phases.PLAYER_ATTACK:
		progress_bar_node.value += delta
		#print(delta)
		#print(progress_bar_node.value)
		if Input.is_action_just_pressed("ui_accept"):
			var min_time = progress_bar_node.max_value/2 - target_progress_bar.value/2
			var max_time = progress_bar_node.max_value/2 + target_progress_bar.value/2
			#print(min_time, max_time)
			#print(progress_bar_node.value)
			if progress_bar_node.value > min_time and progress_bar_node.value < max_time:
				#print("Boss Hit")
				target_progress_bar.value -= 1.0/boss_node.max_health
				boss_node.apply_damage(1)
				_on_phase_timer_timeout()
				
func _on_phase_timer_timeout():
	match current_phase:
		phases.SHOOTING:
			current_phase = phases.PLAYER_ATTACK
			phase_timer_node.start(player_attack_phase_time)
			boss_node.can_shoot = false
		phases.PLAYER_ATTACK:
			current_phase = phases.SHOOTING
			phase_timer_node.start(boss_phase_time)
			boss_node.can_shoot = true
		_:
			print("Phase ERROR")
	progress_bar_node.value = 0
