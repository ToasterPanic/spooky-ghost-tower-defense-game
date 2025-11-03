extends CharacterBody3D

var shot_time = 1
var type = 1
var upgrade = 1

func update_stats():
	$Area/CollisionShape3D.shape = SphereShape3D.new()
	$Area/CollisionShape3D.shape.set_radius(global.stats[type][upgrade].range)

func initiate_upgrade():
	get_node(str(type) + "-" + str(upgrade)).visible = false
	upgrade += 1
	
	update_stats()
	
func initiate(new_type, new_upgrade):
	type = new_type
	upgrade = new_upgrade
	
	update_stats()
	
	get_node(str(type) + "-" + str(upgrade)).visible = false

func _process(delta: float) -> void:
	shot_time -= delta
	
	get_node(str(type) + "-" + str(upgrade)).visible = true
	
	var fire = false
	
	if shot_time <= 0:
		shot_time = global.stats[type][upgrade].fire_rate
		fire = true
	
	for n in $Area.get_overlapping_bodies():
		if n.has_meta("enemy"):
			$Crosshair.visible = true
			$Crosshair.global_position = n.global_position
			
			if fire:
				if type == 1:
					$Basic.play()
				elif type == 2:
					$Knife.play()
				elif type == 3:
					$Sniper.play()
				elif type == 4:
					$Sniper.play()
					
				n.set_meta("health", n.get_meta("health") - global.stats[type][upgrade].damage)
				
			return
			
	$Crosshair.visible = false
