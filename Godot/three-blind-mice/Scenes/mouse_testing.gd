extends Node2D

@onready var multi_mouse: MultiMouse = $MultiMouse

func _ready():
	multi_mouse.attach_to_window(0) # HWND on Windows, ignored elsewhere
	multi_mouse.enable()
	multi_mouse.motion.connect(_on_motion)
	multi_mouse.button.connect(_on_button)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_motion() -> void:
	multi_mouse.motion.
	pass

func _on_button() -> void:
	pass
