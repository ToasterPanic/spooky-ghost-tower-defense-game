extends Node3D

var time = 0
var next_spawn_time = 1
var time_until_next_wave = 60
var current_wave = 1
var current_wave_section = 0
var current_spawned = 0

var ghost_scene = preload("res://scenes/ghost.tscn")

@onready var player = $Player

func _ready() -> void:
	for n in $PathNodes.get_children():
		n.visible = false

func _on_resume_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$CanvasLayer/Control/PauseMenu.visible = false

func _process(delta: float) -> void:
	if !$CanvasLayer/Control/PauseMenu.visible:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	time += delta 
	if time_until_next_wave > 0:
		current_wave_section = 0
		current_spawned = 0
		
		next_spawn_time = 1
		if Input.is_action_pressed("start_next_wave"):
			time_until_next_wave -= delta * 30
		else:
			time_until_next_wave -= delta
	else:
		next_spawn_time -= delta
	
	if next_spawn_time <= 0:
		var ghost = ghost_scene.instantiate()
		
		ghost.type = global.waves[current_wave][current_wave_section].type
		ghost.position = $PathNodes/Node1.position
		
		$Enemies.add_child(ghost)
		
		current_spawned += 1
		
		if global.waves[current_wave][current_wave_section].amount == current_spawned:
			current_wave_section += 1
			current_spawned = 0
			
			if global.waves[current_wave].size() - 1 < current_wave_section:
				time_until_next_wave = 60
				current_wave += 1
				current_wave_section = 0
		
		next_spawn_time = global.waves[current_wave][current_wave_section].interval
		
	for n in $CanvasLayer/Control/Hotbar/Container.get_children():
		if n.get_name() == player.hotbar[player.selected_item]:
			n.modulate = Color(1, 1, 1, 1)
		else:
			n.modulate = Color(.8, .8, .8, 0.5)
			
	for n in $CanvasLayer/Control/Viewmodel.get_children():
		n.visible = n.get_name() == player.hotbar[player.selected_item]
	
	if time_until_next_wave > 0:
		$CanvasLayer/Control/WaveLabel.text = "NEXT WAVE IN " + str(floori(time_until_next_wave)) + " SECONDS"
	else:
		$CanvasLayer/Control/WaveLabel.text = "WAVE " + str(current_wave)
		
	$CanvasLayer/Control/Moneys.text = "$" + str(player.money)
	
	if player.selected_item == 1:
		$CanvasLayer/Control/InfoPanel.visible = true
		$CanvasLayer/Control/InfoPanel/Label.text = "[b]Basic Turret[/b]\n$50"
	elif player.selected_item == 2:
		$CanvasLayer/Control/InfoPanel.visible = true
		$CanvasLayer/Control/InfoPanel/Label.text = "[b]Knife Turret[/b]\n$50"
	elif player.selected_item == 3:
		$CanvasLayer/Control/InfoPanel.visible = true
		$CanvasLayer/Control/InfoPanel/Label.text = "[b]Rocket Turret[/b]\n$150"
	elif player.selected_item == 4:
		$CanvasLayer/Control/InfoPanel.visible = true
		$CanvasLayer/Control/InfoPanel/Label.text = "[b]Sniper Turret[/b]\n$150"
	else:
		$CanvasLayer/Control/InfoPanel.visible = false
		
		var collider = $Player/Raycast.get_collider()
		
		if collider:
			if collider.has_meta("enemy"):
				$CanvasLayer/Control/InfoPanel.visible = true
				$CanvasLayer/Control/InfoPanel/Label.text = "[b]" + collider.type + "[/b]"
			else:
				$CanvasLayer/Control/InfoPanel.visible = true
				var name = ["Basic Turret", "Knife Turret", "Rocket Turret", "Sniper Turret"][collider.type - 1]
				$CanvasLayer/Control/InfoPanel/Label.text = "[b]" + name + "[/b]\n Upgrade #" + str(collider.upgrade)
				if collider.upgrade != 3:
					$CanvasLayer/Control/InfoPanel/Label.text = $CanvasLayer/Control/InfoPanel/Label.text + "\n[Left Click] Upgrade for $" + str(global.stats[collider.type][collider.upgrade].upgrade_cost)
		
		
		
	if Input.get_vector("move_left", "move_right", "move_forward", "move_backward").length() > 0.1:
		$CanvasLayer/Control/Viewmodel.position.x = 600 + (sin(time * 6) * 64)
		$CanvasLayer/Control/Viewmodel.position.y = 128 + (sin(time * 12) * 48)
	else:
		var pos_x = $CanvasLayer/Control/Viewmodel.position.x - 600
		$CanvasLayer/Control/Viewmodel.position.x = 600 + (pos_x / 1.1)
		
		var pos_y = $CanvasLayer/Control/Viewmodel.position.y - 128
		$CanvasLayer/Control/Viewmodel.position.y = 128 + (pos_y / 1.1)
