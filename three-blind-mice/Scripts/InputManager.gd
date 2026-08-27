extends Node

@onready var player: Node3D = $"../Room1/Player"

var backwards = false
var forwards = false
var turnLeft = false
var turnRight = false
var speedyTurn = false


func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	_resetBools()
	_processInput()
	_movement()

#region Movement/Input
func _resetBools() -> void:
	backwards = false
	forwards = false
	turnLeft = false
	turnRight = false
	speedyTurn = false

func _movement() -> void:
	var playerBody: Node = player.get_child(0)
	var velocity = Vector3(0,0,0)
	var currentRotation = playerBody.rotation_degrees.y
	
	if backwards:
		velocity.z += 0.1
	if forwards:
		velocity.z -= 0.1
	
	velocity = velocity.rotated(Vector3.UP, deg_to_rad(currentRotation))

	
	playerBody.move_and_collide(velocity)
	
	var rotationSpeed = 0.1
	if speedyTurn: rotationSpeed = rotationSpeed*2
	if turnLeft:
		playerBody.rotate_y(1*rotationSpeed)
	if turnRight:
		playerBody.rotate_y(-1*rotationSpeed)

func _processInput() -> void:
	var leftInput = _leftFootInput()
	var rightInput = _rightFootInput()
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

func _mouseInputSorter(event: InputEventMouseButton) -> void:
	var leftMouseButton = 0
	var rightMouseButton = 0
	var centreMouseButton = 0
	print(str(event.button_index) + " || " + str(event.device))
	match event.device:
		1: # LEFT INPUT
			leftMouseButton = event.button_index 
			_leftFootInput(leftMouseButton)
		2: # RIGHT INPUT
			rightMouseButton = event.button_index
			_rightFootInput(rightMouseButton)
		3: # CENTRE INPUT
			centreMouseButton = event.button_index
		_: # IGNORE OTHER MICE
			pass
	

func _leftFootInput(lmb: int) -> int:
	var leftInputNum = 0
	# REPLACE HERE WITH MOUSE INPUTS
	if Input.is_action_pressed("LeftFootForward"):
		leftInputNum +=1
	if Input.is_action_pressed("LeftFootBack"):
		leftInputNum -=1
	#
	
	clampi(leftInputNum,-1,1)
	
	return leftInputNum

func _rightFootInput(rmb: int) -> int:
	var rightInputNum = 0
	
	# REPLACE HERE WITH MOUSE INPUTS
	if Input.is_action_pressed("RightFootForward"):
		rightInputNum += 1
	if Input.is_action_pressed("RightFootBack"):
		rightInputNum -= 1
	#
	
	clampi(rightInputNum,-1,1)
	
	return rightInputNum
#endregion
