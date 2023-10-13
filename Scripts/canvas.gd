extends Node3D

@export var canvasTexture : Texture

@onready var canvasMesh := $CanvasMesh
@onready var viewport := $SubViewport
@onready var poopMesh := $MeshInstance3D
var viewTex : ViewportTexture

func _ready():
	viewTex = viewport.get_texture()
	var mat := StandardMaterial3D.new()
	mat.albedo_texture = viewport.get_texture()
	poopMesh.material_override = mat
func _process(delta):
	pass
func _input(event):
	if event.is_action_pressed("debug_test"):
		compare_images()

func compare_images():
	var image: Image = canvasTexture.get_image()
	var compareImage: Image = viewTex.get_image()
	
	var imageBytes: PackedByteArray  = image.get_data()
	var compareImageBytes: PackedByteArray = compareImage.get_data()

	var imageIntArray:   PackedInt32Array = imageBytes.to_int32_array()
	var compareIntArray: PackedInt32Array = compareImageBytes.to_int32_array()
	var byteArraySize : int = imageIntArray.size()
	print(byteArraySize - compareIntArray.size())
	var pixelThreshold := 1000
	
	var diff := 0.0
	var percentdiff := 0.0
	for i in range(byteArraySize):
		if abs(imageIntArray[i] - compareIntArray[i]) > pixelThreshold:
			diff += 1.0

	percentdiff = diff / float(byteArraySize)

	print("percentdiff: ", percentdiff)
