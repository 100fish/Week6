extends Node

@onready var ears: AudioListener3D = $Body/Ears
@onready var cheese: Node = $"../Cheese"
@onready var sound: AudioStreamPlayer3D = $"../Cheese/CheeseSound"
@onready var body: CharacterBody3D = $Body
var directionFacing: Vector2 = Vector2.UP
var previousFacing: Vector2 = Vector2.UP
var currentAngle = 0
var previousAngle = 0
var currentCheeseAngle = 0
var previousCheeseAngle = 0
var cheeseVector: Vector2

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
	currentAngle = body.rotation.y
	if(currentAngle != previousAngle): directionFacing = Vector2.UP.rotated(-currentAngle)
	previousFacing = directionFacing
	previousAngle = currentAngle

func _calculateCheeseVectors() -> void:
	var twoVectorCheese: Vector2 = Vector2(cheese.global_position.x, cheese.global_position.z)
	var twoVector: Vector2 = Vector2(body.global_position.x, body.global_position.z)
	cheeseVector = twoVector-twoVectorCheese
	#var direction = directionFacing.angle_to(-cheeseVector)
	var direction = directionFacing.normalized().dot(-cheeseVector.normalized())
	currentCheeseAngle = direction
	#if(currentCheeseAngle != previousCheeseAngle): print("Cheese: ", rad_to_deg(currentCheeseAngle)); 
	previousCheeseAngle = currentCheeseAngle

func _calculateDifference() -> void:
	sound.volume_db = currentCheeseAngle * 20
	
	#print(rad_to_deg(difference))
