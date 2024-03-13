class_name SaverLoader
extends Node


@onready var player = %Player

func save_game():
	var file = FileAccess.open("user://savegame.data", FileAccess.WRITE)
	
	var saved_game:SavedGame = SavedGame.new()
	
	saved_game.player_health = player.health
	saved_game.player_money = player.money
	saved_game.player_position = player.global_position
	
	# needed for saving enemy positions.
	for cell in get_tree().get_nodes_in_group("cell"):
		saved_game.cell_positions.append(cell.global_position)
	
	
	ResourceSaver.save(saved_game, "user://savegame.tres")

func load_game():
	var saved_game:SavedGame = load("user://savegame.tres") as SavedGame
	
	player.money = saved_game.player_money
	player.health = saved_game.player_health
	player.global_position = saved_game.player_position
	
	for cell in get_tree().get_nodes_in_group("cell"):
		cell.get_parent().remove_child(cell)
		cell.queue_free()
	for position in saved_game.cell_positions:
		var cell_scene = preload("res://code/enemies/mob.tscn")
		var new_cell = cell_scene.instantiate()
		#need to figure out how to add the cell back to the screen
		new_cell.global_position = position
