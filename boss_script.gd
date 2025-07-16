extends CharacterBody2D

@export var cooldown = 0.25
@export var bullet_scene : PackedScene
@export var fire_rate = 1
var can_shoot = true
@export var max_health = 5
var current_health
var bullet_pattern = [[0,90,180,270],[45,135,225,315]]
var current_number = 0

func _ready():
	$Timer.start(fire_rate)
	current_health = max_health


func shoot(bullet_rotation):
	if can_shoot:
		var b = bullet_scene.instantiate()
		get_tree().root.add_child(b)
		b.start(self.global_position, bullet_rotation)

func _on_timer_timeout():
	for degrees in bullet_pattern[current_number]:
		shoot(degrees)
	current_number += 1
	if current_number == bullet_pattern.size():
		current_number = 0
		
func apply_damage(damage):
	current_health -= damage
	if current_health <= 0:
		print("You win!!!!")
