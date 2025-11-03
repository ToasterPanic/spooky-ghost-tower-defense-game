extends Node3D



func set_panel(text: String) -> void:
	for n in $CanvasLayer/Control.get_children():
		if n.is_class("Panel"):
			n.visible = n.get_name() == text


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_close_all_panels_pressed() -> void:
	set_panel("bingus boingus")


func _on_settings_pressed() -> void:
	set_panel("Settings")


func _on_extras_credits_pressed() -> void:
	set_panel("Credits")


func _on_play_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
