class_name SaverLoader
extends Node

@onready var player = %Player

func save_game():
	var file = FileAccess.open("user://savegame.data", FileAccess.WRITE)
	
	var saved_game:SavedGame = SavedGame.new()
	
	saved_game.player_health = player.health # Saving player health
	saved_game.player_money = player.money # Saving players money
	saved_game.player_position = player.global_position # saving players position
	saved_game.player_speed = player.speed # Saving players current speed
	
	# section for saving gun information
	# current issue as of April 2nd, 944 pm, when loading back sprite shows that I still have a pistol even though I don't
	saved_game.player_sword = player.sword
	saved_game.player_pistol = player.pistol
	saved_game.player_smg = player.smg
	saved_game.player_duet = player.duet
	saved_game.player_shotgun = player.shotgun
	saved_game.player_sniper = player.sniper 
	saved_game.player_rocket = player.rocket
	

	
	# needed for saving enemy positions.
	for cell in get_tree().get_nodes_in_group("cell"):
		saved_game.cell_positions.append(cell.global_position)
	
	
	ResourceSaver.save(saved_game, "user://savegame.tres")

func load_game():
	var saved_game:SavedGame = load("user://savegame.tres") as SavedGame
	
	# Reloading from file
	player.money = saved_game.player_money 
	player.set_health(saved_game.player_health) # setting the players health to what was saved in the file
	player.global_position = saved_game.player_position
	player.speed = saved_game.player_speed
	
	# Loading weapon values from file
	player.sword = saved_game.player_sword
	player.pistol = saved_game.player_pistol
	player.smg = saved_game.player_smg
	player.duet = saved_game.player_duet
	player.shotgun = saved_game.player_shotgun
	player.sniper = saved_game.player_sniper
	player.rocket = saved_game.player_rocket

	
	for cell in get_tree().get_nodes_in_group("cell"):
		cell.get_parent().remove_child(cell)
		cell.queue_free()
	for position in saved_game.cell_positions:
		var cell_scene = preload("res://code/enemies/mob.tscn")
		var new_cell = cell_scene.instantiate()
	
		new_cell.global_position = position
