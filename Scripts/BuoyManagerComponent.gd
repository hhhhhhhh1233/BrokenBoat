extends Node3D

class_name BuoyManagerComponent

@export_group("Body Properties")
@export var rigidBody : RigidBody3D
@export var buoys : Array[Node3D]

@export_group("Planetary Values")
@export var planetPosition : Vector3
@export var planetRadius : float = 30

@export_group("Force Values")
@export var gravityStrength : float = 20
@export var floatingStrength : float = 100

@export_group("Damping Values")
@export var airLinearDamp : float = 1
@export var airAngularDamp : float = 5
@export var waterLinearDamp : float = 2
@export var waterAngularDamp : float = 10

func setDamp(linear : float, angular : float):
	rigidBody.linear_damp = linear
	rigidBody.angular_damp = angular

func _ready():
	rigidBody.gravity_scale = 0
	setDamp(airLinearDamp, airAngularDamp)

func _physics_process(_delta):
	var planetNormal = (global_position - planetPosition).normalized()
	for buoy in buoys:
		# Gravity that tugs each floater point towards the gravitational center
		rigidBody.apply_force(-planetNormal.normalized() * (gravityStrength / buoys.size()), buoy.global_position)
		
		# Calculate if the floater points are in the water
		var difference = (buoy.global_position - planetPosition).length() - planetRadius
		
		# If it's less the difference is less than zero then that means the point is under water so apply an upward force
		if difference < 0:
			setDamp(waterLinearDamp, waterAngularDamp)
			rigidBody.apply_force(planetNormal.normalized() * (floatingStrength / buoys.size()) * abs(difference), buoy.global_position)
		else:
			setDamp(airLinearDamp, airAngularDamp)
