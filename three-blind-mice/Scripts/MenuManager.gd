extends CanvasLayer

var menu_scene_path = 'res://Scenes/Menu.tscn'
const menu_scene: PackedScene = preload("res://Scenes/Menu.tscn")
var main_scene_path = 'res://Scenes/room_1.tscn'
const main_scene: PackedScene = preload('res://Scenes/room_1.tscn')

#Sabian note: From what I can find you can't view autoload scripts in the inspector unless at runtime, therefore avoid using export on them
#@export var scenes: Array[PackedScene] = []
var scenes: Array[PackedScene] = [menu_scene, main_scene]

func _ready() -> void:
	for i in scenes.size():
		print(scenes[i])


	# SABIAN ADJUSTED THIS CODE
func _move_to_new_scene(SceneID, _OldScene) -> void:
	#game = self.get_parent()
	
	#create instance
	var world_scene = SceneID.instantiate()
	
	#clear old scene
	get_tree().current_scene.queue_free()
	
	#attach new scene
	get_tree().root.add_child(world_scene)
	get_tree().current_scene = world_scene
	

func _on_start_game_pressed() -> void:
	var game = self.get_parent()
	var world_scene = main_scene.instantiate()
	game.add_child(world_scene)
	InputManager.enabled = true
	InputManager.player = get_tree().get_nodes_in_group("Player")[0]

func _on_quit_pressed() -> void:
	get_tree().quit()

#SABIAN ADDED THIS CODE TO LINK TO MainMenu.gd
func _on_new_game_pressed() -> void:
	_move_to_new_scene(scenes[1],scenes[0])
