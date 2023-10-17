extends FilmManipulator

class_name CameraObscura

var texture : ViewportTexture
var currentTexture


@export var startsWithFilm := true
@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var viewport := $SubViewport
@onready var viewFinder = $ViewFinder

func _ready():
	film = Photo.new()
	if startsWithFilm:
		hasFilm = true
		film.holder = self
		
	await RenderingServer.frame_post_draw
	texture = viewport.get_texture()
	#set viewfinder from script so godot doesn't break
	var mat := StandardMaterial3D.new()
	mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	mat.albedo_texture = texture
	viewFinder.set_surface_override_material(0,mat)

func _take_picture():
	if(hasFilm):
		film.tex = ImageTexture.create_from_image(texture.get_image())

