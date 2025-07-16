extends Area2D

@export var speed = -250

func _process(delta):
	position += transform.x * speed * delta

func start(pos, rot):
	self.global_position = pos
	self.rotation_degrees = rot


func _on_area_entered(area):
	if area.is_in_group("player"):
		print("hit")
		queue_free()
