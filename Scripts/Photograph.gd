extends Node

class_name  Photo


var holder : FilmManipulator
var tex : ImageTexture

func _transfer(newHolder : FilmManipulator):
	if newHolder.hasFilm:
		return
	
	holder.hasFilm = false
	holder.film = null
	holder.taken.emit()
	
	newHolder.hasFilm = true
	newHolder.film = self
	newHolder.given.emit()
	
	holder = newHolder
	
