extends Node3D

@onready var playerNameBox: TextEdit = $CheeseUI/MarginContainer/Start/MarginContainer/StartingContainer/Name

@onready var scoreLabel: Label = $CheeseUI/MarginContainer/Gameplay/GameplayContainer/Score
@onready var timeLabel: Label = $CheeseUI/MarginContainer/Gameplay/GameplayContainer/Time
var score: float
var time: float = 90
var playerName: String = "???"

var gameplay: bool = false

@export var cheeseObject: Node3D
@export var leftCorner: Node3D
@export var rightCorner: Node3D

@onready var start: Button = $CheeseUI/MarginContainer/Start/MarginContainer/StartingContainer/MarginContainer/Start
@onready var startPanel: Control = $CheeseUI/MarginContainer/Start
@onready var endPanel: Control = $CheeseUI/MarginContainer/End

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InputManager.eat_cheese.connect(_eat_cheese)
	_move_cheese()
	
	start.connect('pressed', _on_start_pressed)
	
	endPanel.position.x = 2000
	endPanel.position.y = 2000
	pass 

func _on_start_pressed():
	startPanel.position.y = 2000
	startPanel.position.x = 2000
	
	playerName = playerNameBox.text
	
	print(playerName)
	
	gameplay = true
	pass

func _process(delta: float) -> void:
	if(gameplay == true):
		
		time -= delta
		if(time > 0):
			time -= delta
			timeLabel.text = "Time " + str(int(time))
		else:
			_on_game_end()
			pass
		pass

func _on_game_end():
	gameplay = false
	endPanel.position.x = 0
	endPanel.position.y = 0

func _eat_cheese() -> void:
	score += 1
	$"../Player/Moo".pitch_scale = 15.0
	$"../Player/Moo".play()
	scoreLabel.text = "Score: " + str(int(score))
	
	_move_cheese()

func _move_cheese() -> void:
	var newPosition = Vector2(randf_range(rightCorner.position.x, leftCorner.position.x), randf_range(rightCorner.position.y, leftCorner.position.y))
	cheeseObject.position = Vector3(newPosition.x, newPosition.y, cheeseObject.position.z)
	cheeseObject.rotation_degrees.y = randf_range(-180, 180)
