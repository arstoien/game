extends CharacterBody2D

@export var speed: float = 100.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var direction: Vector2 = Vector2.ZERO
var last_look: Vector2 = Vector2.DOWN

func get_input():
	direction = Input.get_vector("left", "right", "up", "down")

func _physics_process(delta):
	get_input()
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()

	if direction == Vector2.ZERO:
		# idle: face last direction
		if last_look.y > 0:      anim.play("MCUp")
		elif last_look.y < 0:    anim.play("MCDown")
		elif last_look.x > 0:    anim.play("MCRight")
		else:                    anim.play("MCLeft")
		return

	if abs(direction.x) >= abs(direction.y):
		if direction.x > 0:
			last_look = Vector2.RIGHT
			anim.play("MCRight")
		else:
			last_look = Vector2.LEFT
			anim.play("MCLeft")
	else:
		if direction.y > 0:
			last_look = Vector2.DOWN
			anim.play("MCUp")
		else:
			last_look = Vector2.UP
			anim.play("MCDown")
