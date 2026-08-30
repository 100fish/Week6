extends Node2D


@onready var player: Node3D = $"../Player"
var screenPosition: Vector2

func _process(delta: float) -> void:
	var camera = get_viewport().get_camera_3d()
	if camera:
		screenPosition = camera.unproject_position($"../Player/Body".global_position)
		#print("Player Screen Position: ", screenPosition)
	# Call queue_redraw to update the line every frame if the vector changes
	queue_redraw()

func _draw() -> void:
	var facingStart = screenPosition
	var facingEnd = facingStart + player.directionFacing*100
	var cheeseStart = screenPosition
	var cheeseEnd = screenPosition - player.cheeseVector*10
	#draw_line(facingStart, facingEnd, Color.RED, 4.0)
	draw_circle(facingEnd, 6.0, Color.RED)
	draw_line(cheeseStart, cheeseEnd, Color.BLUE, 4.0)
	draw_circle(cheeseEnd, 6.0, Color.BLUE)
