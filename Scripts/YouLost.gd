extends Area2D

@export_file var FirstLevel : String = "res://Levels/Level1.tscn"

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_tree().change_scene_to_file(FirstLevel)
