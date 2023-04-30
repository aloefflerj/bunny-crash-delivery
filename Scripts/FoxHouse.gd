extends Area2D

func _process(_delta):
	var values : Array = get_overlapping_bodies()
	for value in values:
		if value.is_type('Bunny'):
			Global.lose_level()
			get_tree().change_scene_to_file(get_parent().YouLost)
		if value.is_type('Food'):
			get_tree().change_scene_to_file(get_parent().NextLevel)
			Global.win_level()
