extends Node3D

@onready var animPlayer = $AnimationPlayer

func _perma_open():
	animPlayer.play("FakeWallOpen")

func _close():
	animPlayer.play("RESET")
