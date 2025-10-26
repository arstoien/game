extends CharacterBody2D

@export var speed: float = 100.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var direction: Vector2 = Vector2.ZERO
var last_look: Vector2 = Vector2.DOWN # Start facing down

func get_input():
	direction = Input.get_vector("left", "right", "up", "down")

func _physics_process(delta):
	get_input()
	direction = direction.normalized()
	velocity = direction * speed
	
	handle_animation() # Separate animation logic for clarity
	
	move_and_slide()

#---

## Animation Handling Function

func handle_animation():
	if direction == Vector2.ZERO:
		# Idle: Face the last direction traveled.
		# Note: The animation names should now be dedicated idle animations.
		if last_look == Vector2.UP:
			anim.play("MCIdleUp")
		elif last_look == Vector2.DOWN:
			anim.play("MCIdleDown")
		elif last_look == Vector2.LEFT:
			anim.play("MCIdleLeft")
		elif last_look == Vector2.RIGHT:
			anim.play("MCIdleRight")
		return

	# Movement: Determine the dominant direction for movement and set 'last_look'.
	# We compare the absolute values of x and y to see which is the primary direction.
	if abs(direction.x) >= abs(direction.y):
		# Horizontal Movement
		if direction.x > 0:
			last_look = Vector2.RIGHT
			anim.play("MCRight") # Use a dedicated movement animation
		else:
			last_look = Vector2.LEFT
			anim.play("MCLeft")
	else:
		# Vertical Movement
		if direction.y > 0:
			last_look = Vector2.DOWN
			anim.play("MCDown") # Use a dedicated movement animation
		else:
			last_look = Vector2.UP
			anim.play("MCUp")
