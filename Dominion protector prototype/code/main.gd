extends Node2D
@onready var _saver_loader:SaverLoader = %SaverLoader
@export var mob_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerObjects/Inventory.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# creates a new game and enablesfunctionality of of objects
func new_game():
	get_tree().call_group("mobs", "queue_free")
	#$GameObjects/Music.play()
	$Menu.show_message("Get Ready")
	await get_tree().create_timer(2.1).timeout
	$PlayerObjects/Inventory.show()
	$EnemyObjects/EnemyTimer.start()
	$PlayerObjects/Player.start($PlayerObjects/Player/PlayerStartPosition.position)
	$PlayerObjects/Base.start($PlayerObjects/Base/BaseStartPosition.position)
	$GameObjects/StartTimer.start()

# the game over or loss condition
func game_over():
	$PlayerObjects/Inventory.hide()
	$GameObjects/Music.stop()
	$GameObjects/GameOverSound.play() 
	$Menu.show_game_over()
	stop_processes()

# disables functionality of objects
func stop_processes():
	$PlayerObjects/Player.stop()
	$PlayerObjects/Base.stop()
	$EnemyObjects/EnemyTimer.stop()
	get_tree().call_group("mob", "queue_free")
	get_tree().call_group("coin", "queue_free")

# spawns enemies through the timer interval
func _on_enemy_timer_timeout():
	var mob = mob_scene.instantiate()

	var mob_spawn_location = $EnemyObjects/EnemySpawn
	mob.position = mob_spawn_location.position
	
	add_child(mob)
