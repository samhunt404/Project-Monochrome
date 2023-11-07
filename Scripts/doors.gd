extends Node3D

class_name Door

@export var playerOpenable = true
@onready var animPlayer = $AnimationPlayer
@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var area = $Area3D

var closed = true

func _input(event):
	if event.is_action_pressed("Action_Grab") and area.overlaps_body(player) and playerOpenable:
		_temp_open()

func _temp_open():
	if not animPlayer.is_playing():
		animPlayer.play("Open_Close")


func _perma_open():
	if not animPlayer.is_playing() and closed:
		animPlayer.play("Open")
		closed = false

func _close():
	if not animPlayer.is_playing() and not closed:
		animPlayer.play("Close")
		closed = true
