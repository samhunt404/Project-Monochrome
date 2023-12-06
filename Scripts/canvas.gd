extends Node3D

@export var targetTexture : Texture2D
@export var doorToOpen : NodePath
@export var lever : NodePath
@export var sens : int = 400
@export var debugSaveImgs : bool = false
var leverInst
var door

@onready var canvasMesh := $CanvasMesh
@onready var viewport := $SubViewport
@onready var poopMesh := $MeshInstance3D

var viewTex : ViewportTexture
var imgCount : int = 0


func _ready():
	
	
	if(lever != NodePath("")):
		leverInst = get_node(lever)
		leverInst.connect("LeverFired",_start_compare_imgs)
	if(doorToOpen != null):
		door = get_node(doorToOpen)
	
	await RenderingServer.frame_post_draw
	print(viewport.get_texture())
	viewTex = viewport.get_texture()
	var mat := StandardMaterial3D.new()
	mat.albedo_texture = viewport.get_texture()
	poopMesh.material_override = mat

func _start_compare_imgs():
	
	var image: Image = targetTexture.get_image()
	var compareImage: Image = viewTex.get_image()
	
	image.decompress()
	compareImage.decompress()
	
	var ratio = 256.0 / float(targetTexture.get_height())
	image.resize(targetTexture.get_width() * ratio, 256);
	@warning_ignore("integer_division")
	var targRect = Rect2i(Vector2i((256 - image.get_width())/2,0),Vector2i(image.get_width(),image.get_height()))
	var resizedCompare = Image.create(image.get_width(),image.get_height(),false,compareImage.get_format())
	resizedCompare.blit_rect(compareImage,targRect,Vector2i(0,0))
	
	if(debugSaveImgs):
		image.save_png("res://Data/RefImage" + name + str(imgCount) +".png")
		resizedCompare.save_png("res://Data/CompImage" + name + str(imgCount) +".png")
	
	imgCount += 1
	
	var difference = image.compute_image_metrics(resizedCompare,true)
	
	
	if(difference["mean_squared"] < sens):
		door.call_thread_safe("_perma_open")
	print(difference["mean_squared"])
