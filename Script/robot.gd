extends Node2D

# inches
const field_size = 144
var pix_per_inch = OS.get_window_size().x / field_size

var inches_per_second = 38
var degrees_per_second = 180

var actions = []

var current_action: Action = Action.new(0, 0, "stub")
var current_action_index = -1

func _ready():
	current_action.finished = true
	waitFor(3.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(current_action.finished && current_action_index + 1 < actions.size()):
		current_action_index += 1
		current_action = actions[current_action_index]
		print("start action ", current_action.type)
	
	if(current_action.finished):
		return
		
	if(current_action.type == "forward"):
		var advance_distance = inches_per_second * current_action.speed * delta
		current_action.advanced += advance_distance
	
		position -= Vector2(0, advance_distance * pix_per_inch).rotated(rotation)
		
		if(abs(current_action.advanced) >= abs(current_action.advance)):
			current_action.finished = true
			
	elif(current_action.type == "backwards"):
		var advance_distance = inches_per_second * current_action.speed * delta
		current_action.advanced -= advance_distance
		
		position += Vector2(0, advance_distance * pix_per_inch).rotated(rotation)
		
		if(abs(current_action.advanced) >= abs(current_action.advance)):
			current_action.finished = true
			
	elif(current_action.type == "strafe"):
		var multiplier = 1
		if(current_action.advance < 0):
			multiplier = -1
		
		var advance_distance = inches_per_second * current_action.speed * delta  * multiplier
		current_action.advanced += advance_distance
		
		position += Vector2(advance_distance * pix_per_inch, 0).rotated(rotation)
		
		if(abs(current_action.advanced) >= abs(current_action.advance)):
			current_action.finished = true
		
	elif(current_action.type == "rotate"):
		var multiplier = 1
		if(current_action.advance < 0):
			multiplier = -1
		
		var advance_deg = degrees_per_second * current_action.speed * delta * multiplier
		current_action.advanced += advance_deg
		
		rotation_degrees += advance_deg
		
		if(abs(current_action.advanced) >= abs(current_action.advance)):
			current_action.finished = true
			
	elif(current_action.type == "tiltFR"):
		var multiplier = 1
		if(current_action.advance < 0):
			multiplier = -1
		
		var advance_distance = inches_per_second * current_action.speed * delta  * multiplier
		current_action.advanced += advance_distance
		
		var advancePix = advance_distance * pix_per_inch
		
		position -= Vector2(0, advancePix).rotated(deg2rad(45)).rotated(rotation)
		
		if(abs(current_action.advanced) >= abs(current_action.advance)):
			current_action.finished = true
			
	elif(current_action.type == "tiltBL"):
		var multiplier = 1
		if(current_action.advance < 0):
			multiplier = -1
		
		var advance_distance = inches_per_second * current_action.speed * delta  * multiplier
		current_action.advanced += advance_distance
		
		var advancePix = advance_distance * pix_per_inch
		
		position += Vector2(0, advancePix).rotated(deg2rad(45)).rotated(rotation)
		
		if(abs(current_action.advanced) >= abs(current_action.advance)):
			current_action.finished = true
			
	
	elif(current_action.type == "tiltFL"):
		var multiplier = 1
		if(current_action.advance < 0):
			multiplier = -1
		
		var advance_distance = inches_per_second * current_action.speed * delta  * multiplier
		current_action.advanced += advance_distance
		
		var advancePix = advance_distance * pix_per_inch
		
		position -= Vector2(0, advancePix).rotated(deg2rad(-45)).rotated(rotation)
		
		if(abs(current_action.advanced) >= abs(current_action.advance)):
			current_action.finished = true
			
	elif(current_action.type == "tiltBR"):
		var multiplier = 1
		if(current_action.advance < 0):
			multiplier = -1
		
		var advance_distance = inches_per_second * current_action.speed * delta  * multiplier
		current_action.advanced += advance_distance
		
		var advancePix = advance_distance * pix_per_inch
		
		position -= Vector2(0, advancePix).rotated(deg2rad(-45)).rotated(rotation)
		
		if(abs(current_action.advanced) >= abs(current_action.advance)):
			current_action.finished = true
	
	elif(current_action.type == "wait"):
		current_action.advanced += delta
		
		if(current_action.advanced >= current_action.advance):
			current_action.finished = true

func forward(distance, speed):
	add(Action.new(speed, distance, "forward"))

func backwards(distance, speed):
	add(Action.new(speed, distance, "backwards"))
	
func strafeLeft(distance, speed):
	add(Action.new(-speed, distance, "strafe"))

func strafeRight(distance, speed):
	add(Action.new(speed, distance, "strafe"))

func rotateBy(degrees, speed):
	add(Action.new(speed, -degrees, "rotate"))
	
func tiltForwardLeft(distance, speed):
	add(Action.new(speed, distance, "tiltFL"))
	
func tiltBackwardsLeft(distance, speed):
	add(Action.new(speed, distance, "tiltBL"))
	
func tiltForwardRight(distance, speed):
	add(Action.new(speed, distance, "tiltFR"))
	
func tiltBackwardsRight(distance, speed):
	add(Action.new(speed, -distance, "tiltBR"))

func waitFor(seconds):
	add(Action.new(0.0, seconds, "wait"))

func add(action: Action):
	print("add ", action.type)
	actions.push_back(action)

class Action:
	var speed = 0
	var advance = 0
	var type = "forward"
	
	var finished = false
	
	var advanced = 0
	
	func _init(speed, advance, type):
		self.speed = speed
		
		self.advance = advance
		self.type = type
