extends Node2D

const MELE = preload("res://code/enemies/mob.tscn")
const RANGED = preload("res://code/enemies/ranged_mob.tscn")
var ranged
var enemy_array = []
var clean_array = []
var counter
var allowed

var i
var mele_counter
var ranged_counter
var mele_num
var ranged_num

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
	
	if allowed:
		enemy_array = get_tree().get_nodes_in_group("mob")
		if Input.is_action_just_pressed("Spawn_wave") and enemy_array.is_empty():
			i = 0
			mele_counter = 0
			ranged_counter = 0
			counter += 1
			wave()

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
	mele_counter = -1
	ranged_num = 0
	ranged_counter = -1
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
			#mele_num = 4
			ranged_num = 1
			$Timer.start()
		2:
			mele_num = 6
			$Timer.start()
		3:
			$Timer.wait_time = 0.5
			mele_num = 8
			$Timer.start()
		4:
			mele_num = 12
			$Timer.start()
		5:
			mele_num = 15
			$Timer.start()
		6:
			$Timer.wait_time = 0.3
			mele_num = 18
			$Timer.start()
		7:
			mele_num = 21
			$Timer.start()
		8:
			mele_num = 24
			$Timer.start()
		9:
			mele_num = 27
			$Timer.start()
		10:
			$Timer.wait_time = 0.2
			mele_num = 32
			$Timer.start()
		11:
			$Timer.wait_time = 0.2
			mele_num = 32
			$Timer.start()
		12:
			$Timer.wait_time = 0.2
			mele_num = 32
			$Timer.start()
		13:
			$Timer.wait_time = 0.2
			mele_num = 32
			$Timer.start()
		14:
			$Timer.wait_time = 0.2
			mele_num = 32
			$Timer.start()
		15:
			$Timer.wait_time = 0.2
			mele_num = 32
			$Timer.start()
		_:
			## defult case
			pass

# pick a spawn location
func spawn_area(type):
	var rand = randi() % 6 + 1
	
	print(rand)
	
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
	
	mob.position = location.position
	add_child(mob)

# this timer is to prevent enemies from spawning into eachother
func _on_timer_timeout():
	i += 1
	if i <= mele_num + ranged_num:
		if mele_counter <= mele_num:
			mele_counter += 1
			spawn_area(1)
			$Timer.start()
		if ranged_counter <= ranged_num:
			ranged_counter += 1
			spawn_area(2)
			$Timer.start()
