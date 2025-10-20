extends CharacterBody2D

@export var speed: float = 400.0
@export var speed: float = 150.0
@export var debug: bool = false

var facing: String = "down" # remember last direction for idle

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

func _physics_process(_delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("left", "right", "up", "down")

	# movement
	# --- movement logic ---
	if input_dir != Vector2.ZERO:
		velocity = input_dir.normalized() * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	# --- animation logic ---
<<<<<<< HEAD
	if input_dir.y > 0.0:
		facing = "down"
	if facing == "down":
		anim.play ("MCDown")
=======
	if input_dir != Vector2.ZERO:
		# Player is moving
		if input_dir.y > 0.0:
			facing = "down"
			if anim.animation != "MCDown":
				anim.play("MCDown")
		elif input_dir.y < 0.0:
			facing = "up"
			if anim.animation != "MCUp":
				anim.play("MCUp")
		elif input_dir.x > 0.0:
			facing = "right"
			if anim.animation != "MCRight":
				anim.play("MCRight")
		elif input_dir.x < 0.0:
			facing = "left"
			if anim.animation != "MCLeft":
				anim.play("MCLeft")
	else:
		# Player is idle, use the last 'facing' direction
		if facing == "down":
			if anim.animation != "IdleDown":
				anim.play("IdleDown")
		elif facing == "up":
			if anim.animation != "IdleUp":
				anim.play("IdleUp")
		elif facing == "right":
			if anim.animation != "IdleRight":
				anim.play("IdleRight")
		elif facing == "left":
			if anim.animation != "IdleLeft":
				anim.play("IdleLeft")
>>>>>>> 26b8351c95e3317cee8a6bff5791e08b0f265545
