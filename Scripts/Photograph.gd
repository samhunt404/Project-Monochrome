extends Node3D

class_name  Photo

var mat : StandardMaterial3D

@export var tex : ImageTexture

@onready var mesh := $MeshInstance3D

var holder : FilmManipulator


func _ready():
	_sync_texture()

func _sync_texture():
	mat = StandardMaterial3D.new()
	mat.cull_mode = mat.CULL_DISABLED
	mat.resource_local_to_scene = true
	mat.albedo_texture = tex
	mesh.set_surface_override_material(0,mat)

func _transfer(newHolder : FilmManipulator):
	if newHolder.hasFilm:
		return
	
	holder.hasFilm = false
	holder.film = null
	if holder is Lantern:
		holder._sync_texture()
	
	newHolder.hasFilm = true
	newHolder.film = self
	
	holder = newHolder
	if newHolder is Lantern:
		newHolder._sync_texture()
