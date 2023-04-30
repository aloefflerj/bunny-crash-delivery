extends CharacterBody2D
@export var CrashVelocityMultiplier : float = 0.7
@export var SpawnVeloctiyMultiplier : float = 7
var CurrentVelocity : Vector2
var CurrentPosition : Vector2 = Vector2(0, 0)
var Food = preload("res://Nodes/BumpFood.tscn")
var FoodInstantiated : bool = false

func _ready():
	$CollisionShape2D.disabled = true;

func _physics_process(delta):
	slow_down(delta)
	calc_current_position_based_on_path_2d()
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider : CharacterBody2D = collision.get_collider()
		handle_collisions(collider, collision)
		
		collider.get_parent().following = false
		get_parent().following = false
		
func spawn_food(spawn_position: Vector2, spawn_velocity: Vector2):
	var food = Food.instantiate()
	food.set_position(spawn_position)
	food.StartVelocity = spawn_velocity
	self.get_parent().get_parent().get_parent().add_child(food)
	FoodInstantiated = true

func calc_current_position_based_on_path_2d() -> void:
	var current_position = get_position_delta();
	CurrentVelocity = Vector2(
		current_position.x - CurrentPosition.x,
		current_position.y - CurrentPosition.y
	) * Vector2(-1, -1)
	CurrentPosition = current_position

func handle_collisions(
	collided_in_this : CharacterBody2D,
	collision: KinematicCollision2D
	) -> void:
	if (!FoodInstantiated && !collided_in_this.FoodInstantiated):
		collided_in_this.FoodInstantiated = true
		handle_collision(collided_in_this, collision)
	
	
func handle_collision(collider : CharacterBody2D, collision: KinematicCollision2D) -> void:
	var collision_side :String = detect_side_of_collision(collision)
	apply_collision_force(collision_side, collider)
	
	var spawn_velocity = collider.CurrentVelocity + CurrentVelocity * -SpawnVeloctiyMultiplier
	spawn_food(collision.get_position(), spawn_velocity)

func detect_side_of_collision(collision: KinematicCollision2D) -> String:
	var up_velocity : float = collision.get_angle()
	var down_velocity : float = collision.get_angle(Vector2(0, 1))
	var left_velocity : float = collision.get_angle(Vector2(-1, 0))
	var right_velocity : float = collision.get_angle(Vector2(1, 0))
	
	var collision_angles : Array = [up_velocity, down_velocity, left_velocity, right_velocity]
	var collision_keys : Array = ['UP', 'DOWN', 'LEFT', 'RIGHT']
	
	var lowest_angle_value = collision_angles.min()
	var key = collision_angles.find(lowest_angle_value)
	var collision_side = collision_keys[key]
	
	return collision_side
	
func apply_collision_force(side_of_collision: String, collider : CharacterBody2D) -> void:
	match (side_of_collision):
		'UP':
			collider.velocity.y += collider.get_parent().RunSpeed
			collider.velocity += CurrentVelocity
			collider.velocity.y *= CrashVelocityMultiplier
		'DOWN':
			collider.velocity.y += -collider.get_parent().RunSpeed
			collider.velocity += CurrentVelocity
			collider.velocity.y *= CrashVelocityMultiplier
		'LEFT':
			collider.velocity.x += collider.get_parent().RunSpeed
			collider.velocity += CurrentVelocity
			collider.velocity.x *= CrashVelocityMultiplier
		'RIGHT':
			collider.velocity.x += -collider.get_parent().RunSpeed
			collider.velocity += CurrentVelocity
			collider.velocity.x *= CrashVelocityMultiplier
			
func slow_down(delta) -> void:
	velocity -= velocity * min(delta/0.4, 1.0)
	
func is_type(type): return type == "Bunny"

func get_type(): return "Bunny"
