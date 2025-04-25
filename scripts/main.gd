extends Node2D

@onready var bird: Bird = $Bird
@onready var ground: Ground = $Ground
@onready var pipe_spawner: PipeSpawner = $PipeSpawner
@onready var fade: Fade = $Fade
@onready var ui: UI = $UI
@onready var sky: DeadZone = $Sky
@onready var saver_loader: SaverLoader = $SaverLoader

var point: int = 0
var highest_point: int = 0
var game_ends: bool = false

func _ready() -> void:
	bird.game_started.connect(_on_game_started)
	sky.bird_entered.connect(_on_bird_crashed)
	ground.bird_crashed.connect(_on_bird_crashed)
	pipe_spawner.bird_crashed.connect(_on_bird_crashed)
	pipe_spawner.point_scored.connect(_on_point_scored)
	saver_loader.loading_game_requested.connect(_on_loading_game_requested)
	saver_loader.saving_game_requested.connect(_on_saving_game_requested)
	
	saver_loader.load_game()
	ui.update_highest_point(highest_point)

func _on_game_started() -> void:
	pipe_spawner.start_spawning_pipes()

func _on_bird_crashed(bird: Node2D) -> void:
	end_game()

func end_game() -> void:
	if not game_ends:
		highest_point = point if point > highest_point else highest_point
		fade.play()
		ground.stop()
		bird.prevent_input()
		pipe_spawner.stop()
		ui.on_game_over()
		ui.update_highest_point(highest_point)
		game_ends = true
		saver_loader.save_game()

func _on_point_scored() -> void:
	point += 1
	ui.update_point(point)

func _on_saving_game_requested(saved_game: SavedGame) -> void:
	saved_game.highest_point = highest_point

func _on_loading_game_requested(saved_game: SavedGame) -> void:
	highest_point = saved_game.highest_point
