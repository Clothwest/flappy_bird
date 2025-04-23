class_name UI extends CanvasLayer

@onready var point_label: Label = $MarginContainer/PointLabel
@onready var game_over_box: VBoxContainer = $MarginContainer/GameOverBox

func _ready() -> void:
	point_label.text = "{0}".format([0])

func update_point(point: int) -> void:
	point_label.text = "{0}".format([point])

func on_game_over() -> void:
	game_over_box.visible = true

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_exit_button_pressed() -> void:
	get_tree().quit()
