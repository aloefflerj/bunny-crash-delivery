extends Area2D

func _process(delta):
	var values : Array = get_overlapping_bodies()
	for value in values:
		if value.is_type('Bunny'):
			Global.lose_level()
		if value.is_type('Food'):
			Global.win_level()
