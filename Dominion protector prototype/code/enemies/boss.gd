extends Mob

var attacking

# Called when the node enters the scene tree for the first time.
func _ready():
	start()

# on spawn
func start():
	$AnimatedSprite2D.play("Idle")
	await get_tree().create_timer(.5).timeout
	
	enter = true
	
	count += 1
	current_count = count
	player = get_node("/root/Main/PlayerObjects/Player")
	base = get_node("/root/Main/PlayerObjects/Base")
	main = get_node("/root/Main")
	speed = 75
	health = 60
	damage = 4
	money_value = 100
	player_range = 125
	base_range = 125
	attacking = false

# called every frame
func _physics_process(delta):
	if not enter:
		return
	
	targeting(delta)
	
	var distance_to_player = position.distance_to(player.position)
	var distance_to_base = position.distance_to(base.position)
	
	if distance_to_player < player_range:
		attack(player)
	elif distance_to_base < base_range:
		attack(base)
	else:
		# normalize enemy movement to prevent fast horizontal movement
		velocity = velocity.normalized() * speed
		
		if velocity.length() > 0:
			$AnimatedSprite2D.play("Movement")
			if attacking == false:
				$AnimatedSprite2D2.play("Default")
		else:
			$AnimatedSprite2D.play("Idle")
		
		# flip the animation based on the direction movement
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
		
		move_and_slide()

func attack(node):
	$AnimationPlayer.play("attack")
	$AnimatedSprite2D.play("Attack")
	$AnimatedSprite2D2.play("Attack")
	attacking = true
	await get_tree().create_timer(.5).timeout
	attacking = false


func _on_damage_area_entered(area):
	if area.is_in_group("player"):
		area.take_damage(damage)
		$Damage/CollisionShape2D.disabled = true
		await get_tree().create_timer(1).timeout
	elif area.is_in_group("base"):
		area.take_damage(damage)
