extends CharacterBody3D

func _physics_process(delta):
	var planetNormal = (global_position - $"../Planet".global_position).normalized()
	var diff = planetNormal - transform.basis.y
	transform.basis.y = planetNormal
	transform.basis = transform.basis.orthonormalized()
	
	
	if Input.is_action_pressed("action"):
		velocity = transform.basis.z * 20
		var turn_dir = Input.get_axis("turn_right", "turn_left")
		global_rotate(planetNormal, turn_dir * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, 1)
		velocity.y = move_toward(velocity.y, 0, 1)
		velocity.z = move_toward(velocity.z, 0, 1)
	
	position += ((global_position - $"../Planet".global_position).length() - 30) * -planetNormal
	
#	velocity += ($"../Planet".position - position).normalized() * 4
#
#	if $"../Planet".has_overlapping_bodies():
#		velocity += -($"../Planet".position - position).normalized() * 5
		
	
	move_and_slide()
