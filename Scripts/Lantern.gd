extends FilmManipulator

@onready var spotLight := $SpotLight3D
@onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	given.connect(_sync_texture)
	taken.connect(_sync_texture)

func _sync_texture():
	if hasFilm:
		spotLight.light_projector = film.tex
	else:
		spotLight.light_projector = null
