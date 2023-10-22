extends RigidBody3D

var planet
var buoys

@export var underWaterDrag = 3;
@export var underWaterAngularDrag = 1;
@export var airDrag = 1;
@export var airAngularDrag = 3; 
@export var floatingPower = 120;

func _ready():
	planet = get_node("../Planet")
	buoys = $Buoys.get_children()

func _physics_process(delta):
	
	
	var planetNormal = (global_position - planet.global_position).normalized()
	
	transform.basis.y = planetNormal
	transform.basis = transform.basis.orthonormalized()
	
	var difference = (global_position - planet.global_position).length() - 30
	
	var accel = Input.get_action_strength("action")
	if accel:
		apply_force(transform.basis.z * 60 * accel)
		var turn_dir = Input.get_axis("turn_right", "turn_left")
		global_rotate(planetNormal, turn_dir * delta)
	else:
		apply_force(-linear_velocity * 0.5)
#	print(linear_velocity)
	
	for buoy in buoys:
		apply_force(-planetNormal.normalized() * 30, buoy.global_position)

	if difference < 0:
		for buoy in buoys:
			apply_force(planetNormal.normalized() * floatingPower * abs(difference), buoy.global_position)
		
	

