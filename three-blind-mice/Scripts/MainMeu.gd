extends CanvasLayer

const main_scene: PackedScene = preload('res://scenes/room_1.tscn')

@onready var new_game = $Menu/MarginContainer/InnerBackground/InnerContainer/ButtonContainer/Button
@onready var quit = $Menu/MarginContainer/InnerBackground/InnerContainer/ButtonContainer2/Button

func _ready():
	load_main_menu()

func load_main_menu():
	new_game.connect('pressed', _on_new_game_pressed)
	quit.connect('pressed', _on_quit_pressed)

func _on_new_game_pressed() -> void:
	var game = self.get_parent()
	self.queue_free()
	var world_scene = main_scene.instantiate()
	game.add_child(world_scene)
	InputManager.enabled = true
	InputManager.player = get_tree().get_nodes_in_group("Player")[0]

func _on_quit_pressed() -> void:
	get_tree().quit()
