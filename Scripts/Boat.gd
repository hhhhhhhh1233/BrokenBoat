extends RigidBody3D

var planet

@export var speed = 150

var bullet = preload("res://Scenes/bullet.tscn")

enum ShipState 
{
	STEERING,
	SHOOTING
}

func _ready():
	planet = get_node("../Planet")

var shipState = ShipState.STEERING

func _physics_process(delta):
	var planetNormal = (global_position - planet.global_position).normalized()
	
	if Input.is_action_just_pressed("swap"):
		if shipState == ShipState.STEERING:
			shipState = ShipState.SHOOTING
		else:
			shipState = ShipState.STEERING
	
	if shipState == ShipState.STEERING:
		var accel = Input.get_action_strength("action")
		if accel:
			apply_force(transform.basis.z * speed * accel)
			var turn_dir = Input.get_axis("turn_right", "turn_left")
			global_rotate(planetNormal, turn_dir * delta)
		else:
			apply_force(-linear_velocity * 0.5)

	if shipState == ShipState.SHOOTING:
		var turn_dir = Input.get_axis("turn_right", "turn_left")
		$Cannon.global_rotate(planetNormal, turn_dir * delta)
		if Input.is_action_just_pressed("action"):
			var instance = bullet.instantiate()
			add_child(instance)
			instance.global_transform = $Cannon/BulletSpawn.global_transform
			instance.apply_impulse(10 * $Cannon/BulletSpawn.global_transform.basis.z)
			instance.reparent(get_node(".."))

