extends Camera3D

var cameraTarget

func _ready():
	cameraTarget = get_node("../Boat/CameraTarget")
	position = cameraTarget.global_position
	rotation = cameraTarget.global_rotation

func _process(_delta):
	if cameraTarget:
		position = lerp(position, cameraTarget.global_position, 0.1)
	
		var curr = Quaternion(global_transform.basis)
		var target = Quaternion(cameraTarget.global_transform.basis)
		transform.basis = Basis(curr.slerp(target,0.1)) 

