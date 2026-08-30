extends Node

@onready var ears: AudioListener3D = $Body/Ears
@onready var cheese: Node = $"../Cheese"
@onready var sound: AudioStreamPlayer3D = $"../Cheese/CheeseSound"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ears.make_current()
	sound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _calculateVectors() -> void:
	pass
