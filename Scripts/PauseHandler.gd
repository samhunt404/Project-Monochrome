extends Node


var pauseScene = preload("res://Instances/pauseMenu.tscn")
var pauseInstance
var isPaused = false
func _ready():
	pauseInstance = pauseScene.instantiate()

func _input(event):
	if(event.is_action_pressed("Control_Pause")):
		isPaused = !isPaused
		if(isPaused):
			add_child(pauseInstance)
		else:
			remove_child(pauseInstance)
