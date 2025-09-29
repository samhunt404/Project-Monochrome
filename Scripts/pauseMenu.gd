extends Control


var player : Player


func _enter_tree():
	player = get_tree().get_nodes_in_group("Player")[0]
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	player.inputDisabled = true

func _exit_tree():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player.inputDisabled = false


func _on_resume_pressed():
	PauseHandler.isPaused = false
	get_parent().remove_child(self)



func _on_quit_pressed():
	get_tree().quit(0)
