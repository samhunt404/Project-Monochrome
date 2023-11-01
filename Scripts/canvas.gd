extends Node3D

@export var targetTexture : Texture
@export var doorToOpen : NodePath
@export var lever : NodePath
var door : Door

@onready var canvasMesh := $CanvasMesh
@onready var viewport := $SubViewport
@onready var poopMesh := $MeshInstance3D

var viewTex : ViewportTexture
var compareThread : Thread


func _ready():
	var leverInst = get_node(lever)
	leverInst.connect("LeverFired",_start_compare_imgs)
	if(doorToOpen != null and get_node(doorToOpen) is Door):
		door = get_node(doorToOpen)
	compareThread = Thread.new()
	viewTex = viewport.get_texture()
	var mat := StandardMaterial3D.new()
	mat.albedo_texture = viewport.get_texture()
	poopMesh.material_override = mat

func _start_compare_imgs():
	print(compareThread.is_alive())
	if(not compareThread.is_alive()):
		compareThread.wait_to_finish()
		compareThread.start(compare_images)

func compare_images():
	var image: Image = targetTexture.get_image()
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
	
	print(percentdiff)
	
	
	if(percentdiff < 0.75):
		door.call_thread_safe("_perma_open")
	
	

func _exit_tree():
	compareThread.wait_to_finish()
