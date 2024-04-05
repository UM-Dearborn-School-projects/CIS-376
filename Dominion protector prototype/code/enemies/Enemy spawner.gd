extends Node2D

const MELE = preload("res://code/enemies/mob.tscn")
const RANGED = preload("res://code/enemies/ranged_mob.tscn")
const STRONG = preload("res://code/enemies/strong_enemy.tscn")
const BOSS = preload("res://code/enemies/boss.tscn")
var ranged
var enemy_array = []
var clean_array = []
var counter
var allowed

var i
var mele_counter
var ranged_counter
var strong_counter
var boss_counter
var mele_num
var ranged_num
var strong_num
var boss_num

# Called when the node enters the scene tree for the first time.
func _ready():
	stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for mob in enemy_array:
		if is_instance_valid(mob):
			clean_array.append(mob)
	
	enemy_array.clear()
	
	if not clean_array.is_empty():
		for mob in clean_array:
			enemy_array.append(mob)
	
	clean_array.clear()
	enemy_array = get_tree().get_nodes_in_group("mob")
	
	if enemy_array.is_empty():
		allowed = true
	
	if allowed:
		if Input.is_action_just_pressed("Spawn_wave"):
			allowed = false
			i = 0
			mele_counter = 0
			ranged_counter = 0
			strong_counter = 0
			boss_counter = 0
			mele_num = 0
			ranged_num = 0
			strong_num = 0
			boss_num = 0
			counter += 1
			wave()
			await get_tree().create_timer(1).timeout

# see if we started
func set_allowed(allowed):
	if allowed == false:
		counter = 0
	
	self.allowed = allowed

# start by showing the waves
func start():
	$CanvasLayer/WaveCounter.show()

# stop and reset this class
func stop():
	$CanvasLayer/WaveCounter.hide()
	enemy_array = get_tree().get_nodes_in_group("mob")
	counter = 0
	mele_num = 0
	mele_counter = 0
	ranged_num = 0
	ranged_counter = 0
	strong_num = 0
	strong_counter = 0
	boss_num = 0
	boss_counter = 0
	i = 0
	allowed = false

# wave counter for number of enemies
func wave():
	if counter <= 15:
		$CanvasLayer/WaveCounter.text = "Wave #" + str(counter)
	else :
		# win condition
		var main = get_node("/root/Main")
		main.setWin()
		main.game_over()
	
	match  counter:
		1:
			$Timer.wait_time = 1.0
			mele_num = 4
			$Timer.start()
		2:
			mele_num = 4
			ranged_num = 2
			$Timer.start()
		3:
			$Timer.wait_time = 0.8
			ranged_num = 8
			$Timer.start()
		4:
			mele_num = 10
			ranged_num = 4
			$Timer.start()
		5:
			mele_num = 13
			ranged_num = 6
			$Timer.start()
		6:
			$Timer.wait_time = 0.6
			mele_num = 16
			ranged_num = 8
			$Timer.start()
		7:
			mele_num = 21
			ranged_num = 10
			$Timer.start()
		8:
			mele_num = 24
			ranged_num = 12
			$Timer.start()
		9:
			mele_num = 27
			ranged_num = 15
			$Timer.start()
		10:
			$Timer.wait_time = 0.2
			mele_num = 20
			strong_num = 6
			ranged_num = 20
			$Timer.start()
		11: 
			mele_num = 25
			strong_num = 10
			ranged_num = 15
			$Timer.start()
		12:
			mele_num = 10
			strong_num = 16
			ranged_num = 15
			$Timer.start()
		13:
			$Timer.wait_time = 0.1
			strong_num = 25
			ranged_num = 20
			$Timer.start()
		14:
			strong_num = 15
			ranged_num = 20
			boss_num = 1
			$Timer.start()
		15:
			strong_num = 25
			ranged_num = 25
			boss_num = 5
			$Timer.start()
		_:
			## defult case
			pass

# pick a spawn location
func spawn_area(type):
	var rand = randi() % 6 + 1
	
	match rand:
		1:
			var mob_spawn_location = $Right
			spawn(mob_spawn_location , type)
		2:
			var mob_spawn_location = $Right2
			spawn(mob_spawn_location , type)
		3:
			var mob_spawn_location = $Left
			spawn(mob_spawn_location , type)
		4:
			var mob_spawn_location = $Left2
			spawn(mob_spawn_location , type)
		5:  
			var mob_spawn_location = $Down
			spawn(mob_spawn_location , type)
		6:
			var mob_spawn_location = $Down2
			spawn(mob_spawn_location , type)

# spawn at this location
func spawn(location, type):
	
	var mob
	
	if type == 1:
		mob = MELE.instantiate()
	elif type == 2:
		mob = RANGED.instantiate()
	elif type == 3:
		mob = STRONG.instantiate()
	elif type == 4:
		mob = BOSS.instantiate()
	
	mob.position = location.position
	add_child(mob)

# this timer is to prevent enemies from spawning into eachother
func _on_timer_timeout():
	i += 1
	if i <= mele_num + ranged_num + strong_num + boss_num:
		var avilable = []
		
		if mele_counter < mele_num and mele_num != 0:
			avilable.append(1)
		if ranged_counter < ranged_num and ranged_num != 0:
			avilable.append(2)
		if strong_counter < strong_num and strong_num != 0:
			avilable.append(3)
		if boss_counter < boss_num and boss_num != 0:
			avilable.append(4)
		
		var choice = 0
		if (avilable.size() > 0):
			choice = randi() % avilable.size()
		var selection = avilable[choice]
		
		if selection == 1:
			mele_counter += 1
			spawn_area(1)
			$Timer.start()
		if selection == 2:
			ranged_counter += 1
			spawn_area(2)
			$Timer.start()
		if selection == 3:
			strong_counter += 1
			spawn_area(3)
			$Timer.start()
		if selection == 4:
			boss_counter += 1
			spawn_area(4)
			$Timer.start()
