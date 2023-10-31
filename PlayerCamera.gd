extends Camera3D

var currentTarget
var boat
var steeringCameraTarget
var shootingCameraTarget

func _ready():
	steeringCameraTarget = get_node("../Boat/CameraTarget")
	boat = get_node("../Boat")
	shootingCameraTarget = get_node("../Boat/Cannon/CameraTarget")
	
	position = steeringCameraTarget.global_position
	rotation = steeringCameraTarget.global_rotation

func _process(_delta):
	if boat.shipState == boat.ShipState.SHOOTING:
		currentTarget = shootingCameraTarget
	else:
		currentTarget = steeringCameraTarget
		
	if currentTarget:
		global_transform = global_transform.interpolate_with(currentTarget.global_transform, 0.1)

