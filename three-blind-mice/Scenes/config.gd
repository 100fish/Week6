extends Control

@onready var mouse_manager: Node2D = $"../../../MouseManager"
@onready var device_info: Label = $MarginContainer/InnerBackground/InnerContainer/DeviceInfo

@onready var left_mouse: TextEdit = $MarginContainer/InnerBackground/InnerContainer/LeftMouse
@onready var right_mouse: TextEdit = $MarginContainer/InnerBackground/InnerContainer/RightMouse
@onready var middle_mouse: TextEdit = $MarginContainer/InnerBackground/InnerContainer/MiddleMouse

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	device_info.text = mouse_manager.deviceStatus
	
	InputManager.leftDevice = int(left_mouse.text)
	InputManager.rightDevice = int(right_mouse.text)
	InputManager.middleDevice = int(middle_mouse.text)
	
	pass
