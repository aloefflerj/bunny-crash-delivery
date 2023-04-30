extends Path2D

@export var LayerIndex : int

func _on_send_bunny(send_bunny_dto: SendBunnyDTO):
	if (send_bunny_dto.LayerIndex == LayerIndex):
		$RoadFollower.following = true
		$RoadFollower.RunSpeed = send_bunny_dto.Speed
