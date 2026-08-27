extends Node

#region Initialise

@onready var player: Node3D = $"../Room1/Player"

var rotationSpeed: float = 1.0
var movementSpeed: float = 1.0
var speedyBoost: float = 1.5

var backwards = false
var forwards = false
var turnLeft = false
var turnRight = false
var speedyTurn = false

var leftMouse = 0
var rightMouse = 0
var middleMouse = 0

var leftMouseInputEvent: InputEventMouseButton
var rightMouseInputEvent: InputEventMouseButton
var middleMouseInputEvent: InputEventMouseButton

#endregion

#region Update
func _process(_delta: float) -> void:
	
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

	print(str(event.button_index) + " || " + str(event.device))
	match event.device:
		1: # LEFT INPUT
			if (event.button_index == 4): leftMouse = 1
			if (event.button_index == 5): leftMouse = -1
		2: # RIGHT INPUT
			if (event.button_index == 4): rightMouse = 1
			if (event.button_index == 5): rightMouse = -1
		3: # CENTRE INPUT
			pass
		_: # IGNORE OTHER MICE
			pass

func _leftFootInput() -> int:
	var leftInputNum = 0
	# REPLACE HERE WITH MOUSE INPUTS
	if Input.is_action_pressed("LeftFootForward"):
		leftInputNum +=1
	if Input.is_action_pressed("LeftFootBack"):
		leftInputNum -=1
	#
	
	clampi(leftInputNum,-1,1)
	
	return leftInputNum
func _rightFootInput() -> int:
	var rightInputNum = 0
	
	# REPLACE HERE WITH MOUSE INPUTS
	if Input.is_action_pressed("RightFootForward"):
		rightInputNum += 1
	if Input.is_action_pressed("RightFootBack"):
		rightInputNum -= 1
	#
	
	clampi(rightInputNum,-1,1)
	
	return rightInputNum

func _processInput() -> void:
	var leftInput = leftMouse #_leftFootInput()
	var rightInput = rightMouse #_rightFootInput()
	if(_leftFootInput() != 0): leftInput = _leftFootInput()
	if(_rightFootInput() != 0): rightInput = _rightFootInput()
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
