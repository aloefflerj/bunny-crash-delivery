extends Node2D

class_name FinishedLevelDTO

var Finished : bool
var FinishedState: States
enum States {WON, LOST, PLAYING}

func _init(finished: bool, finished_state: States):
	Finished = finished
	FinishedState = finished_state
