extends Gun

# Called when the node enters the scene tree for the first time.
func _ready():
	set_damage(3)
	set_accuracy(.2)
	set_speed(700)
	set_range(350)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# override the attack method to allow shooting from seven positions at once
func attack():
	if can_shoot:
		var new_bullet_1 = BULLET.instantiate()
		var new_bullet_2 = BULLET.instantiate()
		var new_bullet_3 = BULLET.instantiate()
		var new_bullet_4 = BULLET.instantiate()
		var new_bullet_5 = BULLET.instantiate()
		var new_bullet_6 = BULLET.instantiate()
		var new_bullet_7 = BULLET.instantiate()
		
		new_bullet_1.set_speed(speed)
		new_bullet_1.set_range(range)
		new_bullet_1.set_damage(damage)
		
		new_bullet_2.set_speed(speed)
		new_bullet_2.set_range(range)
		new_bullet_2.set_damage(damage)
		
		new_bullet_3.set_speed(speed)
		new_bullet_3.set_range(range)
		new_bullet_3.set_damage(damage)
		
		new_bullet_4.set_speed(speed)
		new_bullet_4.set_range(range)
		new_bullet_4.set_damage(damage)
		
		new_bullet_5.set_speed(speed)
		new_bullet_5.set_range(range)
		new_bullet_5.set_damage(damage)
		
		new_bullet_6.set_speed(speed)
		new_bullet_6.set_range(range)
		new_bullet_6.set_damage(damage)
		
		new_bullet_7.set_speed(speed)
		new_bullet_7.set_range(range)
		new_bullet_7.set_damage(damage)
		
		play_sound()
		
		new_bullet_1.global_position = $Pivot/Weapon/ShootingPoint1.global_position
		new_bullet_1.global_rotation = $Pivot/Weapon/ShootingPoint1.global_rotation + randf_range(-accuracy,accuracy)
		
		new_bullet_2.global_position = $Pivot/Weapon/ShootingPoint2.global_position
		new_bullet_2.global_rotation = $Pivot/Weapon/ShootingPoint2.global_rotation + randf_range(-accuracy,accuracy)
		
		new_bullet_3.global_position = $Pivot/Weapon/ShootingPoint2.global_position
		new_bullet_3.global_rotation = $Pivot/Weapon/ShootingPoint2.global_rotation + randf_range(-accuracy,accuracy)
		
		new_bullet_4.global_position = $Pivot/Weapon/ShootingPoint2.global_position
		new_bullet_4.global_rotation = $Pivot/Weapon/ShootingPoint2.global_rotation + randf_range(-accuracy,accuracy)
		
		new_bullet_5.global_position = $Pivot/Weapon/ShootingPoint2.global_position
		new_bullet_5.global_rotation = $Pivot/Weapon/ShootingPoint2.global_rotation + randf_range(-accuracy,accuracy)
		
		new_bullet_6.global_position = $Pivot/Weapon/ShootingPoint2.global_position
		new_bullet_6.global_rotation = $Pivot/Weapon/ShootingPoint2.global_rotation + randf_range(-accuracy,accuracy)
		
		new_bullet_7.global_position = $Pivot/Weapon/ShootingPoint2.global_position
		new_bullet_7.global_rotation = $Pivot/Weapon/ShootingPoint2.global_rotation + randf_range(-accuracy,accuracy)
		
		owner.add_child(new_bullet_1)
		owner.add_child(new_bullet_2)
		owner.add_child(new_bullet_3)
		owner.add_child(new_bullet_4)
		owner.add_child(new_bullet_5)
		owner.add_child(new_bullet_6)
		owner.add_child(new_bullet_7)
		
		reset()

# reload time
func _on_timer_timeout_shotgun():
	can_shoot = true
