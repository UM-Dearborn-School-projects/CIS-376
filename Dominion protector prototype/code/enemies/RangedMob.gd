extends Mob

var player_array = []
var clean_array = []
var target_enemy
var BULLET

func _ready():
	BULLET = preload("res://code/projectiles/enemy_bullet.tscn")
	start()

# on spawn
func start():
	can_shoot = false
	$AnimatedSprite2D.play("Idle")
	await get_tree().create_timer(.75).timeout
	enter = true
	
	$ShootingTimer.start()
	accuracy = .2
	count += 1
	current_count = count
	player = get_node("/root/Main/PlayerObjects/Player")
	base = get_node("/root/Main/PlayerObjects/Base")
	main = get_node("/root/Main")
	money_value = 20
	speed = 75
	health = 5
	damage = 1

# called every frame
func _physics_process(delta):
	if not enter:
		return 
		
	detect_target()
	shoot()
	movement(delta)
	
	velocity = velocity.normalized() * speed
		
	if velocity.length() > 0:
		$AnimatedSprite2D.play("Movement")
	else:
		$AnimatedSprite2D.play("Idle")
	
	# flip the animation based on the direction movement
	$AnimatedSprite2D.flip_v = false
	$AnimatedSprite2D.flip_h = velocity.x < 0
	
	move_and_slide()

# move
func movement(delta):
	var direction
	if target_enemy != null && position.distance_to(target_enemy.global_position) < 200:
		direction = global_position.direction_to(target_enemy.global_position)
		velocity = direction * speed * 0
	elif position.distance_to(player.global_position) < 450:
		direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
	else:
		direction = global_position.direction_to(base.global_position)
		velocity = direction * speed

# shoot the target
func shoot():
	if(target_enemy != null):
		if can_shoot:
			 # Calculate the direction vector from the player to the marker
			var direction = $pivot.global_position - target_enemy.global_position
			# Calculate the rotation angle
			var rotation_angle = atan2(direction.y, direction.x)
			# Convert radians to degrees
			rotation_angle = rad_to_deg(rotation_angle)
			# Apply rotation to the marker
			$pivot.rotation_degrees = rotation_angle + 180
			
			$pivot/ShootingPoint.look_at(target_enemy.global_position)
			shootBullets()
			can_shoot = false
			$ShootingTimer.start()

# spawn bullets
func shootBullets():
	$AnimatedSprite2D.play("Attack")
	var new_bullet_one = BULLET.instantiate()
	
	new_bullet_one.set_damage(damage)
	
	new_bullet_one.global_position = $pivot/ShootingPoint.global_position
	new_bullet_one.global_rotation = $pivot/ShootingPoint.global_rotation + randf_range(-accuracy,accuracy)
	
	$pivot/ShootingPoint.add_child(new_bullet_one)

# find the player objects
func detect_target():
	for player in player_array:
		if is_instance_valid(player):
			clean_array.append(player)
	
	player_array.clear()
	
	for player in clean_array:
		player_array.append(player)
	
	clean_array.clear()
	
	if player_array.size() > 0:
		var current_position = position
		var max_dif = 999999
		var diffrance 
		var flag
		
		for i in player_array.size():
			diffrance = current_position.distance_to(player_array[i].position)
			if(diffrance < max_dif):
				max_dif = diffrance
				flag = i
			i += 1
			
			target_enemy = player_array[flag]

#func _on_range_body_entered(body):
	#if body.is_in_group("player"):
		#print("Player is in range")
		#player_array.append(body)
	#if body.is_in_group("base"):
		#player_array.append(body)
#
#func _on_range_body_exited(body):
	#if body.is_in_group("player") or body.is_in_group("base"):
		#var count = body.get_count()
		#var i = 0
		#for player in player_array:
			#if count == player.get_count():
				#if player_array[i] == target_enemy:
					#target_enemy = null
				#player_array.remove_at(i)
			#i += 1
		

func _on_shooting_timer_timeout():
	can_shoot = true


func _on_range_area_entered(area):
	if area.is_in_group("player"):
		player_array.append(area)
	if area.is_in_group("base"):
		player_array.append(area)


func _on_range_area_exited(area):
	if area.is_in_group("player") or area.is_in_group("base"):
		var count = area.get_count()
		var i = 0
		for player in player_array:
			if count == player.get_count():
				if player_array[i] == target_enemy:
					target_enemy = null
				player_array.remove_at(i)
			i += 1
