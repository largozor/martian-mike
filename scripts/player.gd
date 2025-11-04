extends CharacterBody2D
class_name Player


const SPEED = 125.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite = $PlayerAnimation

var active = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y >= 500:
			velocity.y = 500

	# Handle jump.
	var direction = 0
	if active == true:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			jump(JUMP_VELOCITY)

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = (direction == -1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	update_animations(direction)

func update_animations(direction) -> void:
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y <= 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")

func jump(force: int) -> void:
	velocity.y = force

func reset() -> void:
	print("Reset Player")
