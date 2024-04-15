extends Node2D

"""
This class manages the game state and determines when and how game objects are shown
"""

@onready var _saver_loader:SaverLoader = %SaverLoader
@export var mob_scene: PackedScene

var isWin

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerObjects/Inventory.hide()
	$PlayerObjects/Inventory.hide_all()
	$PlayerObjects/Inventory.update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# creates a new game and enables functionality of of objects
func new_game():
	get_tree().call_group("mobs", "queue_free")
	$GameObjects/Music.play()
	$Menu.show_message("Get Ready")
	await get_tree().create_timer(2.1).timeout
	$PlayerObjects/Inventory.show()
	$PlayerObjects/Player.start($PlayerObjects/Player/PlayerStartPosition.position)
	$PlayerObjects/Base.start($PlayerObjects/Base/BaseStartPosition.position)
	$EnemyObjects/Enemyspawner.start()
	$GameObjects/StartTimer.start()
	$EnemyObjects/Enemyspawner.set_allowed(true)
	$PlayerObjects/Shop.start()
	isWin = false

# the game over or loss condition, This stops the game and sets the main menu
func game_over():
	get_tree().paused = true
	await get_tree().create_timer(1).timeout
	get_tree().paused = false
	
	$PlayerObjects/Inventory.hide_all()
	$PlayerObjects/Inventory.hide()
	$GameObjects/Music.stop()
	$EnemyObjects/Enemyspawner.stop()
	$PlayerObjects/Shop.stop()
	$PlayerObjects/Tower_Placement.reset()
	
	if (isWin):
		win()
	else :
		loss()
	
	stop_processes()

func win():
	$Menu.show_game_won()

func loss():
	$GameObjects/GameOverSound.play() 
	$Menu.show_game_over()

func setWin():
	isWin = true

# disables functionality of objects within the game after game_over()
func stop_processes():
	$PlayerObjects/Player.stop()
	$PlayerObjects/Base.stop()
	$EnemyObjects/Enemyspawner.stop()
	#$EnemyObjects/EnemyTimer.stop()
	get_tree().call_group("mob", "queue_free")
	get_tree().call_group("coin", "queue_free")

# spawns enemies through the timer interval (disabled)
#func _on_enemy_timer_timeout():
	#var mob = mob_scene.instantiate()
#
	#var mob_spawn_location = $EnemyObjects/EnemySpawn
	#mob.position = mob_spawn_location.position
	#
	#add_child(mob)
