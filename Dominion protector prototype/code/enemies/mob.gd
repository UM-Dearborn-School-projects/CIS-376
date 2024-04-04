extends CharacterBody2D

class_name Mob

var health
var speed
var damage
var player
var base
var main
var accuracy
var can_shoot
static var count = 0
var current_count
var money_value = 25

var enter

# Called when the node enters the scene tree for the first time.
func _ready():
	start()

func start():
	$Laser.hide()
	$AnimatedSprite2D.play("Spawn")
	await get_tree().create_timer(.5).timeout
	$AnimatedSprite2D.play("Idle")
	await get_tree().create_timer(.25).timeout
	
	enter = true
	
	count += 1
	current_count = count
	player = get_node("/root/Main/PlayerObjects/Player")
	base = get_node("/root/Main/PlayerObjects/Base")
	main = get_node("/root/Main")
	speed = 50
	health = 6
	damage = 2

# the mob will attack when it is at close range and will walk twards either the base or player
func _physics_process(delta):
	
	if not enter:
		return
	
	targeting(delta)
	
	var distance_to_player = position.distance_to(player.position)
	var distance_to_base = position.distance_to(base.position)
	
	if distance_to_player < 75.0:
		attack(player)
	elif distance_to_base < 100.0:
		attack(base)
	else:
		# normalize enemy movement to prevent fast horizontal movement
		velocity = velocity.normalized() * speed
		
		if velocity.length() > 0:
			$AnimatedSprite2D.play("Movement")
		else:
			$AnimatedSprite2D.play("Idle")
		
		# flip the animation based on the direction movement
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
		
		move_and_slide()

# move to the base unless it is close to the player
func targeting(delta):
	if position.distance_to(player.global_position) < 350:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
	else:
		var direction = global_position.direction_to(base.global_position)
		velocity = direction * speed

# laser attack at close range (between 50-100 units)
func attack(node):
	$Laser.show()
	$Laser.attack(node)
	$AnimatedSprite2D.play("Attack")
	await get_tree().create_timer(2).timeout

# get the current id number for this mob
func get_count():
	return current_count

# damage dealt
func enemy_take_damage(damage):
	
	if damage == null or health == null:
		return
	
	health -= damage
	if(health <= 0):
		$AnimatedSprite2D.play("Death")
		enter = false
		await get_tree().create_timer(.5).timeout
		
		#enemy drops money on death
		const DROP = preload("res://code/other/money.tscn")
		var new_drop = DROP.instantiate()
		new_drop.set_value(money_value)
		new_drop.global_position = %Marker2D.global_position
		self.main.add_child(new_drop)
		queue_free()

# delete the enemy if they leave the view (disabled)
#func _on_visible_on_screen_notifier_2d_screen_exited():
	#queue_free()

# damage base or player by walkinginto them (disabled)
func _on_area_2d_area_entered(area):
	#if area.is_in_group("player"):
		#area.take_damage(damage)
		#await get_tree().create_timer(1).timeout
	
	#if area.is_in_group("base"):
		#area.take_damage(damage)
		#
		#queue_free()
	
	pass
