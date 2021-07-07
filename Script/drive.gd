extends Node

onready var drive = get_node("../robit")

func _ready():
	drive.tiltForwardRight(20.0, 0.9)
	drive.forward(30.0, 0.8)
	drive.backwards(10.0, 0.8)
	
	drive.rotateBy(207.0, 0.6)
	drive.waitFor(1.5)
	drive.rotateBy(5.0, 0.6)
	drive.waitFor(1.5)
	drive.rotateBy(5.0, 0.6)
	drive.waitFor(1.5)
	
	drive.rotateBy(-110, 0.45)
	drive.forward(25.0, 0.3)
	drive.rotateBy(223.0, 0.6)
	drive.forward(39.0, 1.0)
	
	drive.backwards(10.0, 1.0)
	drive.tiltBackwardsLeft(16.0, 1.0)
	drive.tiltForwardLeft(23.0, 1.0)
