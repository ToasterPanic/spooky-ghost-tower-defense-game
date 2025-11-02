extends CharacterBody3D

var speed = 2

func _ready() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	return

func _process(delta: float) -> void:
	velocity.y -= 7.68 * delta
	
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	velocity.x = movement_dir.x * speed
	velocity.z = movement_dir.z * speed
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * 0.002)
