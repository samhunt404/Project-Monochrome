extends CharacterBody3D

class_name Player

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#make sure the player doesn't look around while in pause menus and the likes
var mouse_look_enabled = true

#used to control how sensitive the mouse is
@export var speed : float = 5.0
@export var mouse_sens : Vector2 = Vector2(0.005,0.005)
@export var vertical_lim : float = PI/2.0

#access the camera seperately so we aren't tilting the collider when looking up
@onready var cam = $Camera3D

#variables for pickup
@onready var trigger = $GrabbableArea
@onready var hand = $SpringArm3D/Hand

@onready var handManipulator = $Camera3D/Hand
var grabTarget

var film : Photo


func _ready():
	if mouse_look_enabled:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("Walk_Left", "Walk_Right", "Walk_Forward", "Walk_Backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion and mouse_look_enabled:
		
		rotate_y(-event.relative.x * mouse_sens.y)
		cam.rotate_x(-event.relative.y * mouse_sens.x)
		
		#ensure we are within fov
		cam.rotation.x = clamp(cam.rotation.x,-(vertical_lim/2.0),(vertical_lim/2.0))
	
	
	if event.is_action_pressed("Action_Grab"):
		if grabTarget != null:
			grabTarget = null
		else:
			for o in trigger.get_overlapping_bodies():
				if o.is_in_group("Pickup"):
					grabTarget = o
	
	if event.is_action_pressed("Action_Take"):
			for o in trigger.get_overlapping_areas():
				if o.is_in_group("ManipTrigger"):
					var target = o.owner
					if handManipulator.hasFilm:
						handManipulator.film._transfer(target)
					elif target.hasFilm:
						target.film._transfer(handManipulator)
					
	
	if event.is_action_pressed("Action_Interact"):
		for o in trigger.get_overlapping_areas():
			if o.is_in_group("ManipTrigger"):
				var target = o.owner
				if target is CameraObscura:
					target._take_picture()


func _process(_delta):
	if grabTarget != null:
		grabTarget.global_position = lerp(grabTarget.global_position,hand.global_position,0.25)
		grabTarget.global_rotation.y = lerp_angle(grabTarget.global_rotation.y,hand.global_rotation.y,0.25)
