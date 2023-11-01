extends RigidBody3D

@export var gravity = 2.5
@export var deletionRadius = 20

# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
	apply_force(-global_position.normalized() * gravity)

	if global_position.length() < deletionRadius:
		queue_free()	
