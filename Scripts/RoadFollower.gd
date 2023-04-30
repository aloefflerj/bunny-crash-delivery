extends PathFollow2D

@export var Bunny : CharacterBody2D
@export var RunSpeed = 200

var following = false;

func _process(delta):
	if (following):
		follow(delta)
		
func follow(delta: float):
	set_progress(get_progress() + RunSpeed * delta)
