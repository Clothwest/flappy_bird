class_name Ground extends Node2D

signal bird_crashed

@export var speed: float = -150

@onready var ground_1: DeadZone = $Ground1
@onready var ground_2: DeadZone = $Ground2

@onready var sprite_1: Sprite2D = $Ground1/Sprite2D
@onready var sprite_2: Sprite2D = $Ground2/Sprite2D

func _ready() -> void:
	ground_1.bird_entered.connect(_on_dead_zone_bird_entered)
	ground_2.bird_entered.connect(_on_dead_zone_bird_entered)
	sprite_2.global_position.x = sprite_1.global_position.x + sprite_1.texture.get_width()

func _process(delta: float) -> void:
	sprite_1.global_position.x += speed * delta
	sprite_2.global_position.x += speed * delta
	if sprite_1.global_position.x < -1 * sprite_1.texture.get_width():
		sprite_1.global_position.x = sprite_2.texture.get_width()
	if sprite_2.global_position.x < -1 * sprite_2.texture.get_width():
		sprite_2.global_position.x = sprite_1.texture.get_width()

func _on_dead_zone_bird_entered(bird: Node2D) -> void:
	bird_crashed.emit(bird)
	stop()
	(bird as Bird).stop()

func stop() -> void:
	speed = 0
