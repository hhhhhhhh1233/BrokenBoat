extends RigidBody3D

var planet
var buoys
#
#@export var underWaterDrag = 3
#@export var underWaterAngularDrag = 1
#@export var airDrag = 1
#@export var airAngularDrag = 3
@export var floatingPower = 120
@export var gravityPower = 30
@export var planetRadius = 30
@export var speed = 60

func _ready():
	planet = get_node("../Planet")
	buoys = $Buoys.get_children()

func _physics_process(delta):
	var planetNormal = (global_position - planet.global_position).normalized()
	
	var accel = Input.get_action_strength("action")
	if accel:
		apply_force(transform.basis.z * speed * accel)
		var turn_dir = Input.get_axis("turn_right", "turn_left")
		global_rotate(planetNormal, turn_dir * delta)
	else:
		apply_force(-linear_velocity * 0.5)

	for buoy in buoys:
		# Gravity that tugs each floater point towards the gravitational center
		apply_force(-planetNormal.normalized() * gravityPower, buoy.global_position)
		
		# Calculate if the floater points are in the water
		var difference = (buoy.global_position - planet.global_position).length() - planetRadius
		
		# If it's less the difference is less than zero then that means the point is under water so apply an upward force
		if difference < 0:
			apply_force(planetNormal.normalized() * floatingPower * abs(difference), buoy.global_position)

		
	

