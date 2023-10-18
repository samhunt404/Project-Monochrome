extends Node3D

class_name Door

@export var playerOpenable = true
@onready var animPlayer = $AnimationPlayer
@onready var timer = $Timer
@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var area = $Area3D
func _input(event):
	if event.is_action_pressed("Action_Grab") and area.overlaps_body(player) and playerOpenable:
		_temp_open()

func _temp_open():
	if not animPlayer.is_playing():
		animPlayer.play("Open_Close")


func _perma_open():
	if not animPlayer.is_playing():	
		animPlayer.play("Open")
