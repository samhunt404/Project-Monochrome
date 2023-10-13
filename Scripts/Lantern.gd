extends FilmManipulator

class_name Lantern

@onready var spotLight := $SpotLight3D
@onready var player = get_tree().get_nodes_in_group("Player")[0]

func _sync_texture():
	if hasFilm:
		spotLight.light_projector = film.tex
	else:
		spotLight.light_projector = null
