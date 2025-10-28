extends CharacterBody2D

@export var speed: float = 100.0  # pixels per second
# Called when the node enters the scene tree for the first time.
@export var move_speed: float = 140.0
@export var stop_distance: float = 8.0     # how close we stop (tune)
@export var resume_distance: float = 12.0  # start moving again if farther than this
@export var target_path: NodePath          # drag Player here (recommended)

var target: Node2D
var is_stopped := false

func _ready() -> void:
	pass # Replace with function body.
	# Top-down mode
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	# Decouple from any moving parent (camera/parallax etc.)
	set_as_top_level(true)

	if target_path != NodePath():
		target = get_node_or_null(target_path) as Node2D
	if target == null:
		var players := get_tree().get_nodes_in_group("player")
		if players.size() > 0:
			target = players[0] as Node2D
	if target == null:
		push_warning("Enemy: No target found. Assign target_path or group 'player'.")

func _physics_process(delta: float) -> void:
	if target == null:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var to_player = target.global_position - global_position
	var dist = to_player.length()

	var dir = Vector2.ZERO
	if dist > 0.001:
		dir = to_player / dist

	# Hysteresis: don’t jitter at the edge
	if is_stopped:
		if dist > resume_distance:
			is_stopped = false
	else:
		if dist <= stop_distance:
			is_stopped = true

	if is_stopped:
		velocity = Vector2.ZERO
	else:
		velocity = dir * move_speed

func _process(delta):
	position.y += speed * delta  # move down continuously
# Called every frame. 'delta' is the elapsed time since the previous frame.
	pass
	move_and_slide()
	
	#PETO NEJDE MI TO ???!!!
