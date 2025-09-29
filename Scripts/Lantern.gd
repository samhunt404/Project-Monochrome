extends FilmManipulator

var dim := preload("res://Materials/Bulb_dim.tres")
var lit := preload("res://Materials/Bulb_lit.tres")

@onready var bulb = $MagicLantern/Bulba
@onready var spotLight := $SpotLight3D
@onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	given.connect(_sync_texture)
	taken.connect(_sync_texture)

func _sync_texture():
	if hasFilm:
		bulb.set_surface_override_material(1,lit)
		spotLight.light_projector = film.tex
	else:
		bulb.set_surface_override_material(1,dim)
		spotLight.light_projector = null
