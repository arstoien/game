extends CharacterBody2D

@export var speed: float = 400.0
@export var debug: bool = false

var facing: String = "down" # remember last direction for idle

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

func _physics_process(_delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("left", "right", "up", "down")

	# movement
	if input_dir != Vector2.ZERO:
		velocity = input_dir.normalized() * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	# --- animation logic ---
	if input_dir.y > 0.0:
		facing = "down"
	if facing == "down":
		anim.play ("MCDown")
