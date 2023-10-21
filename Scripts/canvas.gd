extends Node3D

@export var canvasTexture : Texture
@export var doorToOpen : NodePath
var door : Door

@onready var canvasMesh := $CanvasMesh
@onready var viewport := $SubViewport
@onready var poopMesh := $MeshInstance3D

var viewTex : ViewportTexture
var compareThread : Thread


func _ready():
	if(doorToOpen != null and get_node(doorToOpen) is Door):
		door = get_node(doorToOpen)
	compareThread = Thread.new()
	viewTex = viewport.get_texture()
	var mat := StandardMaterial3D.new()
	mat.albedo_texture = viewport.get_texture()
	poopMesh.material_override = mat


func _process(_delta):
	pass
func _input(event):
	if event.is_action_pressed("debug_test"):
		if compareThread.is_started():
			compareThread.wait_to_finish()
		compareThread.start(compare_images.bind())

func compare_images():
	var image: Image = canvasTexture.get_image()
	var compareImage: Image = viewTex.get_image()
	
	image.decompress()
	compareImage.decompress()
	
	var pixelThreshold := 0.25
	
	var diff : int = 0
	var percentdiff := 0.0
	
	var xMax : int = image.get_size().x
	var yMax : int = image.get_size().y
	
	for i in range(0,xMax * yMax):
		var x : int = i % xMax
		@warning_ignore("integer_division")
		var y : int = i / yMax
		var colorA := Vector3(image.get_pixel(x,y).r,image.get_pixel(x,y).g,image.get_pixel(x,y).b)
		var colorB := Vector3(compareImage.get_pixel(x,y).r,compareImage.get_pixel(x,y).g,compareImage.get_pixel(x,y).b)
		if (colorA - colorB).length() > pixelThreshold:
			diff += 1
	
	percentdiff = diff / float(xMax * yMax)
	
	print("Success!" if percentdiff < 0.7 else "Try again!")
	if(percentdiff < 0.7):
		door.call_deferred_thread_group("_perma_open")

func _exit_tree():
	compareThread.wait_to_finish()
