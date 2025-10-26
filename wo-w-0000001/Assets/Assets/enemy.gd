extends CharacterBody2D

@export var speed: float = 100.0  # pixels per second
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta):
	position.y += speed * delta  # move down continuously
# Called every frame. 'delta' is the elapsed time since the previous frame.
	pass
