extends CharacterBody2D

@export var speed: float = 150.0
@export var debug: bool = false

var facing: String = "down" # remember last direction for idle

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

func _physics_process(_delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("Left", "Right", "Up", "Down")

	if input_dir != Vector2.ZERO:
		velocity = input_dir.normalized() * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	 
	if input_dir != Vector2.ZERO:
		if input_dir.y > 0.0:
			facing = "Down"
	if anim.animation != "MCDown":
		anim.play("MCDown")
	elif input_dir.y < 0.0:
			facing = "Up"
	if anim.animation != "MCUp":
		anim.play("MCUp")
	elif input_dir.x > 0.0:
		facing = "Right"
	if anim.animation != "MCRight":
		anim.play("MCRight")
	elif input_dir.x < 0.0:
		facing = "Left"
	if anim.animation != "MCLeft":
		anim.play("MCLeft")
	else:
		if facing == "Down":
			if anim.animation != "IdleDown":
				anim.play("IdleDown")
			
		elif facing == "Up":
			if anim.animation != "IdleUp":
				anim.play("IdleUp")
			elif facing == "Right":
				if anim.animation != "IdleRight":
					anim.play("IdleRight")
				elif facing == "Left":
					if anim.animation != "IdleLeft":
						anim.play("IdleLeft")
