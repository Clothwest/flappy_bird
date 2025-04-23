class_name Fade extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	color_rect.color.a = 0

func play() -> void:
	animation_player.play("fade")
