extends Node2D

@export_file var NextLevel : String
@export_file var YouLost : String = "res://Levels/YouLost.tscn"

func _ready():
	hide_reset_button()
	Global.start_level()

func _process(_delta):
	if Global.is_level_on_lost_state():
		show_reset_button()
		
func show_reset_button():
	$ResetLevelButton.visible = true
	$ResetLevelButton.set_process_mode(Node.PROCESS_MODE_INHERIT)
	
func hide_reset_button():
	$ResetLevelButton.visible = false
	$ResetLevelButton.set_process_mode(Node.PROCESS_MODE_DISABLED)
