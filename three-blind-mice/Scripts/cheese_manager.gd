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

@onready var menuStart: Button = $CheeseUI/Menu/MarginContainer/InnerBackground/InnerContainer/ButtonContainer/Button

@onready var start: Button = $CheeseUI/MarginContainer/Start/MarginContainer/StartingContainer/MarginContainer/Start
@onready var startPanel: Control = $CheeseUI/MarginContainer/Start
@onready var scoreboard: Control = $CheeseUI/Scoreboard
@onready var menu: Control = $CheeseUI/Menu

@onready var scores: Label = $CheeseUI/Scoreboard/MarginContainer/InnerBackground/InnerContainer/Scores

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InputManager.eat_cheese.connect(_eat_cheese)
	_move_cheese()
	
	start.connect('pressed', _on_start_pressed)
	menuStart.connect('pressed', _on_menu_start_pressed)
	
	flingUI(startPanel)
	
	pass 

func flingUI(UI: Control):
	UI.position.x = 2000
	UI.position.y = 2000

func returnUI(UI: Control):
	UI.position.x = 0
	UI.position.y = 0

func _on_menu_start_pressed():
	flingUI(menu)
	flingUI(scoreboard)
	
	returnUI(startPanel)
	

func _on_start_pressed():
	flingUI(startPanel)
	
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
	scores.add_new_score(score)
	get_tree().reload_current_scene() 

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
