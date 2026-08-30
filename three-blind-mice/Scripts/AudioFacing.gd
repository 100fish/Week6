extends Node

@onready var ears: AudioListener3D = $Body/Ears
@onready var cheese: Node = $"../Cheese"
@onready var sound: AudioStreamPlayer3D = $"../Cheese/CheeseSound"
@onready var body = $Body
var directionFacing: Vector2 = Vector2(0,-1)
var previousFacing: Vector2 = Vector2(0,-1)
var currentAngle = 0
var previousAngle = 0
var currentCheeseAngle = 0
var previousCheeseAngle = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ears.make_current()
	sound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_calculateSelfVectors()
	_calculateCheeseVectors()
	_calculateDifference()

func _calculateSelfVectors() -> void:
	currentAngle = body.rotation.y + 2*PI/3
	if(currentAngle != previousAngle): directionFacing = directionFacing.rotated(currentAngle)
	if(directionFacing != previousFacing): print("Facing: ", rad_to_deg(currentAngle)); 
	previousFacing = directionFacing
	previousAngle = currentAngle

func _calculateCheeseVectors() -> void:
	var direction = body.global_position.angle_to(cheese.global_position) + 2*PI/3
	currentCheeseAngle = direction
	if(currentCheeseAngle != previousCheeseAngle): print("Cheese: ", rad_to_deg(currentCheeseAngle)); 
	previousCheeseAngle = currentCheeseAngle

func _calculateDifference() -> void:
	var difference = abs((currentCheeseAngle) - (currentAngle))
	print(rad_to_deg(difference))
