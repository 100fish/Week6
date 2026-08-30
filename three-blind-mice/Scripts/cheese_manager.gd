extends Node3D

@onready var scoreLabel: Label = $CheeseUI/MarginContainer/Gameplay/GameplayContainer/Score
@onready var timeLabel: Label = $CheeseUI/MarginContainer/Gameplay/GameplayContainer/Time
var score: float
var time: float = 90

var gameplay: bool = false

@export var cheeseObject: Node3D
@export var leftCorner: Node3D
@export var rightCorner: Node3D

func _process(delta: float) -> void:
	if(gameplay == true):
		
		time -= delta
		if(time > 0):
			time -= delta
			timeLabel.text = "Time " + str(int(time))
		else:
			gameplay = false
			
			pass
		pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InputManager.eat_cheese.connect(_eat_cheese)
	_move_cheese()
	pass 


func _eat_cheese() -> void:
	score += 1
	scoreLabel.text = "Score: " + str(int(score))
	
	_move_cheese()

func _move_cheese() -> void:
	var newPosition = Vector2(randf_range(rightCorner.position.x, leftCorner.position.x), randf_range(rightCorner.position.y, leftCorner.position.y))
	cheeseObject.position = Vector3(newPosition.x, newPosition.y, cheeseObject.position.z)
	cheeseObject.rotation_degrees.y = randf_range(-180, 180)
