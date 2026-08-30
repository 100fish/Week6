extends Node

@onready var new_game = $Menu/MarginContainer/InnerBackground/InnerContainer/ButtonContainer/Button
@onready var quit = $Menu/MarginContainer/InnerBackground/InnerContainer/ButtonContainer2/Button

func _ready():
	load_main_menu()

func load_main_menu():
	new_game.connect('pressed', MenuManager._on_new_game_pressed)
	quit.connect('pressed', MenuManager._on_quit_pressed)

func _on_start_game_pressed_mainMenu() -> void:
	pass

func _on_new_game_pressed_mainMenu() -> void:
	self.queue_free()
	MenuManager._on_new_game_pressed()
	pass
