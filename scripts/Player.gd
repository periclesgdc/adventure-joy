extends KinematicBody2D

export var GRAVITY = 380
export var JUMP_SPEED = 300

const WALK_MIN_SPEED = 20
const WALK_MAX_SPEED = 200

var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var death_coundown = 3

signal collected
signal died

func get_inputs():
	if Input.is_action_pressed("right"):
		direction.x = 1
		$Animations.flip_h = false
	elif Input.is_action_pressed("left"):
		direction.x = -1
		$Animations.flip_h = true
	else:
		direction.x = 0

func swap_anim():
	if not(is_on_floor()) and not(is_on_ceiling()):
		$Animations.play("jump")
	elif direction.x:
		$Animations.play("walk")
	else:
		$Animations.play("idle")

func collect_item():
	emit_signal("collected")

func _process(delta):
	if death_coundown <= 0:
		death_coundown = 3
		emit_signal("died")

func _physics_process(delta):
	get_inputs()
	swap_anim()
	
	velocity.y += GRAVITY * delta
	velocity.x = direction.x * min(abs(velocity.x) + WALK_MIN_SPEED, WALK_MAX_SPEED)
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_SPEED
	
	if is_on_ceiling():
		death_coundown -= 1 * delta
	else:
		death_coundown = 3

	velocity = move_and_slide(velocity, Vector2.UP)

	position.x = clamp(position.x, 43, 317)
