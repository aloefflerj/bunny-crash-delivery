extends Area2D

@export_file var NextLevel : String
@export_file var YouLost : String = "res://Levels/YouLost.tscn"

func _process(delta):
	var values : Array = get_overlapping_bodies()
	for value in values:
		if value.is_type('Bunny'):
			Global.lose_level()
			get_tree().change_scene_to_file(YouLost)			
		if value.is_type('Food'):
			get_tree().change_scene_to_file(NextLevel)
			Global.win_level()
