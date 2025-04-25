class_name SaverLoader extends Node

const SAVE_LOCATION: String = "user://saved_game.tres"

signal loading_game_requested
signal saving_game_requested

func save_game() -> void:
	var saved_game: SavedGame = SavedGame.new()
	saving_game_requested.emit(saved_game)
	var saved_datas: Array[SavedData] = []
	get_tree().call_group("game_events", "on_save_game", saved_datas)
	saved_game.saved_datas = saved_datas
	ResourceSaver.save(saved_game, SAVE_LOCATION)

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_LOCATION):
		return
	var saved_game: SavedGame = load(SAVE_LOCATION)
	get_tree().call_group("game_events", "on_before_load_game")
	loading_game_requested.emit(saved_game)
	for data in saved_game.saved_datas:
		var scene: PackedScene = load(data.scene_path)
		var restored_node = scene.instantiate()
		owner.add_child(restored_node)
		if restored_node.has_method("on_load_game"):
			restored_node.on_load_game(data)
