class_name PipePair extends Node2D

signal bird_entered
signal point_scored

@onready var top_pipe: DeadZone = $TopPipe
@onready var bottom_pipe: DeadZone = $BottomPipe

var speed: float = 0

func _ready() -> void:
	top_pipe.bird_entered.connect(_on_dead_zone_bird_entered)
	bottom_pipe.bird_entered.connect(_on_dead_zone_bird_entered)

func _process(delta: float) -> void:
	position.x += speed * delta

func set_speed(speed: float) ->void:
	self.speed = speed

func _on_dead_zone_bird_entered(bird: Node2D) -> void:
	bird_entered.emit(bird)

func _on_point_scored(body: Node2D) -> void:
	point_scored.emit()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
