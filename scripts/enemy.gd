extends CharacterBody3D

var speed = 2
var next_node = null
var node_number = 1

var type = "ghost"

@onready var player = get_parent().get_parent().get_node("Player")

func _ready() -> void:
	for n in get_children():
		if n.get_class() == "Sprite3D":
			n.visible = n.get_name() == type
	
	if type == "fast_ghost":
		speed = 4
	elif type == "tanky_ghost":
		set_meta("max_health", 7)
	elif type == "tank_ghost":
		set_meta("max_health", 300)
	
	set_meta("max_health", get_meta("max_health") * ((get_parent().get_parent().current_wave + 6) / 6))
		
	set_meta("health", get_meta("max_health"))

func _process(delta: float) -> void:
	velocity.y -= 7.68 * delta
	
	if get_meta("health") <= 0:
		player.money += get_meta("max_health")
		queue_free()
		return
	
	if next_node == null:
		next_node = get_parent().get_parent().get_node("PathNodes/Node1")
	
	if (next_node.position - position).length() < 0.05:
		node_number += 1
		
		next_node = get_parent().get_parent().get_node("PathNodes/Node" + str(node_number))
		
		if next_node == null:
			get_tree().change_scene_to_file("res://scenes/game.tscn")
			
			return
			
	if (player.position - position).length() <= 0.6:
		look_at(player.position)
		var movement_dir = transform.basis * Vector3(0, 0, -1)
		player.velocity.x = movement_dir.x * 15
		player.velocity.z = movement_dir.z * 15
		
		player.position.x += movement_dir.x * 0.2
		player.position.z += movement_dir.z * 0.2
		
	look_at(next_node.global_position)
	
	var movement_dir = transform.basis * Vector3(0, 0, -1)
	velocity.x = movement_dir.x * speed
	velocity.z = movement_dir.z * speed
	
	move_and_slide()
