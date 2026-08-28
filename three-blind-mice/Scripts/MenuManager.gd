extends CanvasLayer

const main_scene: PackedScene = preload('res://scenes/room_1.tscn')

@export var scenes: Array[PackedScene] = []

func _ready() -> void:
	for i in scenes:
		i.instantiate()
		pass

func _move_to_new_scene(SceneID, OldScene) -> void:
	var game = self.get_parent()
	var world_scene = main_scene.instantiate()
	game.add_child(scenes[SceneID])
	pass

func _on_start_game_pressed() -> void:
	var game = self.get_parent()
	var world_scene = main_scene.instantiate()
	game.add_child(world_scene)
	InputManager.enabled = true
	InputManager.player = get_tree().get_nodes_in_group("Player")[0]

func _on_quit_pressed() -> void:
	get_tree().quit()
