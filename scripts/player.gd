extends CharacterBody3D

var speed = 5
var hotbar = [
	"fist",
	"turret_1",
	"turret_2",
	"turret_3",
	"turret_4",
]
var selected_item = 0
var money = 500

var turret_scene = preload("res://scenes/turret.tscn")

func _ready() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	return

func _process(delta: float) -> void:
	velocity.y -= 7.68 * delta
	
	$PlacementArrow.visible = selected_item != 0
	if $Area.get_overlapping_bodies().size() > 0:
		$PlacementArrow.modulate = Color(1, .5, .5, 1)
	else:
		$PlacementArrow.modulate = Color(1, 1, 1, 1)
	
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	if input.length() > 0:
		var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
		
		if abs(velocity.x) <= speed:
			velocity.x = movement_dir.x * speed
		else:
			velocity.x /= 1.2
		
		if abs(velocity.z) <= speed:
			velocity.z = movement_dir.z * speed
		else:
			velocity.z /= 1.2
	else:
		velocity.x /= 1.2
		velocity.z /= 1.2
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * 0.002)
	elif event.is_action_pressed("next_item"):
		selected_item += 1
		if selected_item > hotbar.size() - 1:
			selected_item = 0
	elif event.is_action_pressed("last_item"):
		selected_item -= 1
		if selected_item < 0:
			selected_item = hotbar.size() - 1
	elif event.is_action_pressed("use"):
		if selected_item > 0:
			for n in $Area.get_overlapping_bodies():
				return
			
			if selected_item <= 2:
				if money < 50:
					return
					
				money -= 50
			else:
				if money < 150:
					return
					
				money -= 150
			
			var turret = turret_scene.instantiate()
			
			turret.global_position = $PlacementArrow.global_position
			turret.initiate(selected_item, 1)
		
			get_parent().get_node("Turrets").add_child(turret)
		else:
			var collider = $Raycast.get_collider()
		
			print(collider)
			
			if collider:
				if collider.has_meta("enemy"):
					return
					
				var upgrade_cost = global.stats[collider.type][collider.upgrade].upgrade_cost 
				
				if money >= upgrade_cost:
					money -= upgrade_cost
					
					collider.initiate_upgrade()
