extends Node

@onready var bird: Bird = $"../Bird"
@onready var ground: Ground = $"../Ground"
@onready var pipe_spawner: PipeSpawner = $"../PipeSpawner"
@onready var fade: Fade = $"../Fade"
@onready var ui: UI = $"../UI"
@onready var sky: DeadZone = $"../Sky"

var point: float = 0
var game_ends: bool = false

func _ready() -> void:
	bird.game_started.connect(_on_game_started)
	sky.bird_entered.connect(_on_bird_crashed)
	ground.bird_crashed.connect(_on_bird_crashed)
	pipe_spawner.bird_crashed.connect(_on_bird_crashed)
	pipe_spawner.point_scored.connect(_on_point_scored)

func _on_game_started() -> void:
	pipe_spawner.start_spawning_pipes()

func _on_bird_crashed(bird: Node2D) -> void:
	end_game()

func end_game() -> void:
	if not game_ends:
		fade.play()
		ground.stop()
		bird.prevent_input()
		pipe_spawner.stop()
		game_ends = true
		ui.on_game_over()

func _on_point_scored() -> void:
	point += 1
	ui.update_point(point)
