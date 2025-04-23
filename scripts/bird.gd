class_name Bird extends CharacterBody2D

signal game_started

@export var gravity_value: float = 900.0
@export var jump_force_value: float = -300
@export var rotation_speed: float = 2.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var max_speed: float = 400

var is_started: bool = false
var should_process_input: bool = true

func _ready() -> void:
	velocity = Vector2.ZERO
	animation_player.play("idle")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and should_process_input:
		if not is_started:
			game_started.emit()
			is_started = true
		jump()
	if is_started:
		velocity.y += gravity_value * delta
	velocity.y = minf(velocity.y, max_speed)
	move_and_slide()
	rotate_bird()

func jump() -> void:
	velocity.y = jump_force_value
	animation_player.play("flap_wings")
	rotation = deg_to_rad(-30.0)

func rotate_bird() -> void:
	if velocity.y > 0 and rad_to_deg(rotation) < 90.0:
		rotation += rotation_speed * deg_to_rad(1)
	elif velocity.y < 0 and rad_to_deg(rotation) > -30.0:
		rotation += rotation_speed * deg_to_rad(1)

func prevent_input() -> void:
	should_process_input = false

func stop() -> void:
	animation_player.stop()
	gravity_value = 0
	velocity = Vector2.ZERO
	should_process_input = false
