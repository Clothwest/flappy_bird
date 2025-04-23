class_name DeadZone extends Area2D

signal bird_entered

func _on_body_entered(body: Node2D) -> void:
	bird_entered.emit(body)
