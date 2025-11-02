extends Node3D

var time = 0

func _on_resume_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$CanvasLayer/Control/PauseMenu.visible = false

func _process(delta: float) -> void:
	time += delta 
	
	print($Player.velocity.length())
	
	if $Player.velocity.length() > 0.1:
		$CanvasLayer/Control/Viewmodel.position.x = 600 + (sin(time * 6) * 64)
		$CanvasLayer/Control/Viewmodel.position.y = 128 + (sin(time * 12) * 48)
	else:
		var pos_x = $CanvasLayer/Control/Viewmodel.position.x - 600
		$CanvasLayer/Control/Viewmodel.position.x = 600 + (pos_x / 1.1)
		var pos_y = $CanvasLayer/Control/Viewmodel.position.y - 128
		$CanvasLayer/Control/Viewmodel.position.y = 128 + (pos_y / 1.1)
