extends FilmManipulator

@onready var mesh = $MeshInstance3D

func _ready():
	given.connect(_sync_texture)
	taken.connect(_sync_texture)

func _sync_texture():
	if(hasFilm):
		mesh.get_surface_override_material(0).set_shader_parameter("tex",film.tex)
	else:
		mesh.get_surface_override_material(0).set_shader_parameter("tex",null)
