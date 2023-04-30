extends CharacterBody2D

var StartVelocity : Vector2
@export var VelocityNormalizer : float = 400

func _ready():
	velocity = StartVelocity * 10
	
func _physics_process(delta):
	if (velocity. y > VelocityNormalizer):
		velocity.y = VelocityNormalizer
		
	if (velocity.y < - VelocityNormalizer):
		velocity.y = -VelocityNormalizer
		
	if (velocity.x > VelocityNormalizer):
		velocity.x = VelocityNormalizer
		
	if (velocity.x < - VelocityNormalizer):
		velocity.x = -VelocityNormalizer
		
	move_and_slide()
	slow_down(delta)
	if (stopped()):
		Global.lose_level()
	
func slow_down(delta) -> void:
	velocity -= velocity * min(delta/0.5, 1.0)
	
func stopped() -> bool:
	return int(velocity.y) == 0 and int(velocity.x) == 0
	
func is_type(type): return type == "Food"

func get_type(): return "Food"
