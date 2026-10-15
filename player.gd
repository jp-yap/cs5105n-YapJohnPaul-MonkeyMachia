
extends CharacterBody2D

@export var speed: float = 250.0
@export var jump_velocity: float = -400.0
@export var gravity: float = 980.0

# Juice element: coyote time
@export var coyote_time: float = 0.12
var coyote_timer: float = 0.0

func _physics_process(delta: float) -> void:
	# Apply gravity while airborne
	if not is_on_floor():
		velocity.y += gravity * delta

	# Remember briefly when the player was last grounded
	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer = maxf(coyote_timer - delta, 0.0)

	# Jump when grounded or during coyote time
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or coyote_timer > 0.0:
			velocity.y = jump_velocity
			coyote_timer = 0.0

	# Horizontal movement
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed

	# Move and handle collisions
	move_and_slide()
