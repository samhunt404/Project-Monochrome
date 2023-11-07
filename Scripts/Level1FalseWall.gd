extends Node3D

@onready var animPlayer = $AnimationPlayer

var closed = false
func _ready():
	_close()

func _perma_open():
	if(closed):
		animPlayer.play("FakeWallOpen")
		closed = false

func _close():
	if(not closed):
		animPlayer.play("RESET")
		closed = true
