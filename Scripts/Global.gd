extends Node

var FinishedLevel : FinishedLevelDTO

func start_level():
	FinishedLevel = FinishedLevelDTO.new(
		false,
		FinishedLevel.States.PLAYING
	)

func win_level():
	if (!FinishedLevel.Finished):
		FinishedLevel = FinishedLevelDTO.new(
			true,
			FinishedLevel.States.WON
		)

func lose_level():
	if (!FinishedLevel.Finished):	
		FinishedLevel = FinishedLevelDTO.new(
			true,
			FinishedLevel.States.LOST
		)
	
