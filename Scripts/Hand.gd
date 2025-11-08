extends FilmManipulator
#
#
#@onready var HandHandler := $Hand
#@onready var pic := $GrabPoint/Photo
#@onready var tempAnim := $Hand/AnimationPlayer
#
#var mat : StandardMaterial3D
#
#func _ready():
	#HandHandler.hide()
	#pic.hide()
	#given.connect(_grab)
	#taken.connect(_relinquish)
	#mat = StandardMaterial3D.new()
	#mat.transparency = mat.TRANSPARENCY_ALPHA_SCISSOR
	#pic.set_surface_override_material(0,mat)
#
#func _grab():
	#HandHandler.show()
	#pic.show()
	#mat.albedo_texture = film.tex
#
#func _relinquish():
	#HandHandler.hide()
	#pic.hide()
