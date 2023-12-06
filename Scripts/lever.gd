extends Node3D


@onready var animPlayer = $Lever/AnimationPlayer
@onready var trigger = $Trigger
@onready var player = get_tree().get_nodes_in_group("Player")[0]


signal LeverFired


func _unhandled_input(event):
	if(event.is_action_pressed("Action_Interact") and trigger.overlaps_body(player) and not animPlayer.is_playing()):
		_activate()
func _activate():
	animPlayer.play("LeverAction")
	LeverFired.emit()
