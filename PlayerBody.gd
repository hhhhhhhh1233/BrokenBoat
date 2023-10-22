extends CharacterBody3D

var planet
var forwardMomentum = 0

func _ready():
	planet = get_node("../Planet")

func _physics_process(delta):
	var planetNormal = (global_position - planet.global_position).normalized()

	transform.basis.y = planetNormal
	transform.basis = transform.basis.orthonormalized()
	
	var accel = Input.get_action_strength("action")
	if accel:
		velocity = transform.basis.z * 20 * accel
		var turn_dir = Input.get_axis("turn_right", "turn_left")
		global_rotate(planetNormal, turn_dir * delta)
		forwardMomentum = 10
	else:
		forwardMomentum = move_toward(forwardMomentum, 0, 0.2)
		velocity = transform.basis.z * forwardMomentum
	
	velocity += -planetNormal.normalized() * 3

	if self in $"../Planet".get_overlapping_bodies():
		velocity += planetNormal.normalized() * 3
	
	move_and_slide()
