class_name Spawnable
extends RigidBody3D

@export var resources_available = 10;

func initialize(start_position):
	position = start_position
