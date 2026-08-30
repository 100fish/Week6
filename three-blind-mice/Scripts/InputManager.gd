extends Node

#region Initialise

@onready var player: Node3D

var rotationSpeed: float = 1.0
var movementSpeed: float = 2.0
var speedyBoost: float = 3.0

var backwards = false
var forwards = false
var turnLeft = false
var turnRight = false
var speedyTurn = false

var leftMouse = 0
var rightMouse = 0
var middleMouse = 0

var leftInputStorage: Array[int] = []
var rightInputStorage: Array[int] = []

var leftMouseInputEvent: InputEventMouseButton
var rightMouseInputEvent: InputEventMouseButton
var middleMouseInputEvent: InputEventMouseButton

var enabled: bool = false
var timer: Node
var cheese: AudioStreamPlayer3D
var ears: Node

#endregion

#region Update
func _inputClear() -> void:
	if(leftInputStorage.size()>0):
		leftInputStorage.remove_at(0)
	if(rightInputStorage.size()>0):
		rightInputStorage.remove_at(0)

func _process(_delta: float) -> void:
	if (!enabled and has_node("../Room1/Player")):
		#update scene
		enabled = true
		player = $"../Room1/Player"
		timer = $"../Room1/Player/Timer"
		timer.connect("timeout", _inputClear)
		ears = $"../Room1/Player/Body/Ears"
		ears.make_current()
		cheese = $"../Room1/Cheese/CheeseSound"
		cheese.play()
		
		print(InputManager.player)
	
	if(enabled):
		if (leftMouseInputEvent != null): 
			_mouseInputSorter(leftMouseInputEvent)
			leftMouseInputEvent = null
		if (rightMouseInputEvent != null): 
			_mouseInputSorter(rightMouseInputEvent)
			rightMouseInputEvent = null
		if (middleMouseInputEvent != null): 
			_mouseInputSorter(middleMouseInputEvent)
			middleMouseInputEvent = null
		
		_processInput()
		_movement()
		_resetVars()
#endregion

#region Movement/Input
func _mouseInputSorter(event: InputEventMouseButton) -> void:

	#print(str(event.button_index) + " || " + str(event.device))
	match event.device:
		15: # LEFT INPUT
			if (event.button_index == 4): leftMouse = 1
			if (event.button_index == 5): leftMouse = -1
		1: # RIGHT INPUT
			if (event.button_index == 4): rightMouse = 1
			if (event.button_index == 5): rightMouse = -1
		10: # CENTRE INPUT
			if (event.button_index == 4): rightMouse = 1
			if (event.button_index == 5): rightMouse = -1
			pass
		_: # IGNORE OTHER MICE
			pass

func _leftFootInput() -> int:
	var leftInputNum = 0
	# REPLACE HERE WITH MOUSE INPUTS
	if Input.is_action_just_pressed("LeftFootForward"):
		leftInputNum +=1
	if Input.is_action_just_pressed("LeftFootBack"):
		leftInputNum -=1
	#
	
	clampi(leftInputNum,-1,1)
	
	return leftInputNum
func _rightFootInput() -> int:
	var rightInputNum = 0
	
	# REPLACE HERE WITH MOUSE INPUTS
	if Input.is_action_just_pressed("RightFootForward"):
		rightInputNum += 1
	if Input.is_action_just_pressed("RightFootBack"):
		rightInputNum -= 1
	#
	
	clampi(rightInputNum,-1,1)
	
	return rightInputNum

func _processInput() -> void:
	#hardcoded to prefer mouse input
	if(_leftFootInput() != 0): 
		leftInputStorage.append(_leftFootInput())
	if(leftMouse != 0):
		leftInputStorage.append(leftMouse)
	if(_rightFootInput() != 0 or rightMouse != 0): 
		rightInputStorage.append(_rightFootInput())
	if(rightMouse != 0):
		rightInputStorage.append(rightMouse)
	
	if(_leftFootInput() != 0 or leftMouse != 0 or _rightFootInput() != 0 or rightMouse != 0):
		#FORWARDSSSSSS
		forwards = true
	
	var leftInput 
	var rightInput
	
	if(leftInputStorage.size()>0): leftInput = leftInputStorage[0]
	else: leftInput = leftMouse
	if(rightInputStorage.size()>0): rightInput = rightInputStorage[0]
	else: rightInput = rightMouse
	#print(leftInputStorage)
	#print(rightInputStorage)
	
	#if(leftInput != 0 and rightInput != 0): print(leftInput, " ", rightInput)
	
	var leftSign = signi(leftInput)
	var rightSign = signi(rightInput)
	
	
	if leftInput == rightInput:
		match leftSign:
			-1:
				backwards = true
			0:
				pass
			1:
				forwards = true
			_:
				pass
	else:
		match leftSign:
			-1:
				if rightSign == 0:
					turnLeft = true
				else: #rightSign == 1
					turnLeft = true
					speedyTurn = true
			0:
				if rightSign == 1:
					turnLeft = true
				else: #rightSign == -1
					turnRight = true
			1:
				if rightSign == 0:
					turnRight = true
				else: #rightSign == -1
					turnRight = true
					speedyTurn = true
	
	
	
	#  --
	#  Possible combinations:
	#  ||(-1,0) (-1,1)|| - ||(0,1) (0,-1)|| - ||(1,0) (1,-1)||
	#  --

func _movement() -> void:
	if(player == null): return
	var playerBody: Node = player.get_child(0)
	var velocity = Vector3(0,0,0)
	var currentRotation = playerBody.rotation_degrees.y
	
	if backwards:
		velocity.z += 0.1 * movementSpeed
	if forwards:
		velocity.z -= 0.1 * movementSpeed
	
	velocity = velocity.rotated(Vector3.UP, deg_to_rad(currentRotation))

	
	playerBody.move_and_collide(velocity)
	
	var rotSpeed = 0.1 * rotationSpeed 
	if speedyTurn: rotSpeed = rotSpeed*speedyBoost
	if turnLeft:
		playerBody.rotate_y(1*rotSpeed)
	if turnRight:
		playerBody.rotate_y(-1*rotSpeed)

func _resetVars() -> void:
	leftMouse = 0
	rightMouse = 0
	middleMouse = 0
	backwards = false
	forwards = false
	turnLeft = false
	turnRight = false
	speedyTurn = false

#endregion
