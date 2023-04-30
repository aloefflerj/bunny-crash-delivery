extends Sprite2D

@export var RoadLayerNumber : int = 1
@export var MinutesToDeliver : int = 20
@export var FoodType : String = 'pizza'
var SendBunnyDTO = load("res://DTO/SendBunnyDTO.gd")

signal send_bunny(send_bunny_dto)

func _unhandled_input(event):
	if event is InputEventMouseButton \
	and event.pressed \
	and not event.is_echo() \
	and event.button_index == MOUSE_BUTTON_LEFT:
		
		var pos = position + offset - ( (texture.get_size() / 2.0) if centered else Vector2() )
		if Rect2(pos, texture.get_size()).has_point(event.position):
			send_bunny_on_his_way()

func send_bunny_on_his_way() -> void:
	var speed = MinutesToDeliver * 10
	var send_bunny_dto : SendBunnyDTO = SendBunnyDTO.new(RoadLayerNumber, speed)
	emit_signal('send_bunny', send_bunny_dto)
