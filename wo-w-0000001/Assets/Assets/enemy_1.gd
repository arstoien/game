extends CharacterBody2D

## --- Public Variables (Set in Inspector) ---
@export var chase_speed: float = 20.0 # Speed when chasing the player
@export var patrol_speed: float = 50.0  # Slower speed for default patrol movement
@export var acceleration: float = 10.0  # How quickly the enemy changes direction/speed

## --- Private Variables ---
var player_node: CharacterBody2D = null # Reference to the player node
var default_direction: Vector2 = Vector2.RIGHT # Initial direction for patrolling


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Attempt to find the player by looking for nodes in the "Player" group.
	var players = get_tree().get_nodes_in_group("Player")
	
	if not players.is_empty():
		# Player found: store the reference
		player_node = players[0] as CharacterBody2D
		print("Enemy found player: ", player_node.name)
	else:
		# Player not found: Enemy will default to patrol/idle behavior
		print("Enemy could not find player! Patrolling right.")


# Called every physics frame (60 times per second by default).
func _physics_process(delta: float) -> void:
	
	var target_velocity: Vector2 = Vector2.ZERO

	# 1. Determine Target Velocity based on Player Status
	if is_instance_valid(player_node):
		
		# --- CHASE MODE ---
		# Get the vector pointing from the enemy to the player
		var direction_vector: Vector2 = global_position.direction_to(player_node.global_position)
		target_velocity = direction_vector * chase_speed

		# OPTIONAL: Flip sprite to face the player (uncomment if you have a Sprite2D)
		# if $Sprite2D:
		#     $Sprite2D.flip_h = direction_vector.x < 0

	else:
		# --- PATROL MODE ---
		# If player is not found, move in the default direction
		target_velocity = default_direction * patrol_speed
		
		# OPTIONAL: Flip sprite to face the patrol direction
		# if $Sprite2D:
		#     $Sprite2D.flip_h = default_direction.x < 0


	# 2. Update Velocity using Lerp (for smooth movement)
	# Lerp (linear interpolation) smoothly moves the current velocity towards the target velocity.
	velocity = velocity.lerp(target_velocity, delta * acceleration)

	# 3. Move and Slide
	move_and_slide()
	
