extends Node3D

@export var canvasTexture : Texture
@onready var canvasMesh := $CanvasMesh
@onready var viewport := $SubViewport
var viewTex : ViewportTexture

func _ready():
	viewTex = viewport.get_texture()
func _process(delta):
	pass

func compare_images():
	print(canvasTexture.get_image().compute_image_metrics(viewTex.get_image(),true))
