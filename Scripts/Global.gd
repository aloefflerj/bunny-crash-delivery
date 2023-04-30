extends Node

var FinishedLevel : FinishedLevelDTO

func start_level() -> void:
	FinishedLevel = FinishedLevelDTO.new(
		false,
		FinishedLevel.States.PLAYING
	)

func win_level() -> void:
	if (!FinishedLevel.Finished):
		FinishedLevel = FinishedLevelDTO.new(
			true,
			FinishedLevel.States.WON
		)

func lose_level() -> void:
	if (!FinishedLevel.Finished):	
		FinishedLevel = FinishedLevelDTO.new(
			true,
			FinishedLevel.States.LOST
		)
	

func is_level_on_lost_state() -> bool:
	return FinishedLevel.FinishedState == FinishedLevelDTO.States.LOST
