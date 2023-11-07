extends Node3D


@onready var animPlayer = $Lever/AnimationPlayer
@onready var trigger = $Trigger
@onready var player = get_tree().get_nodes_in_group("Player")[0]


signal LeverFired


func _input(event):
	if(event.is_action_pressed("Action_Interact") and trigger.overlaps_body(player)):
		_activate()

func _activate():
	if(!animPlayer.is_playing()):
		animPlayer.play("LeverAction")
		LeverFired.emit()
