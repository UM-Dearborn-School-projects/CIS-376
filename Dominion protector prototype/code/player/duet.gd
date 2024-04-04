extends Gun

# Called when the node enters the scene tree for the first time.
func _ready():
	set_damage(3)
	set_accuracy(.2)
	set_range(800)
	set_speed(800)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# override the attack method to allow shooting from two positions at once
func attack():
	if can_shoot:
		var new_bullet_1 = BULLET.instantiate()
		var new_bullet_2 = BULLET.instantiate()
		
		new_bullet_1.set_speed(speed)
		new_bullet_1.set_range(range)
		new_bullet_1.set_damage(damage)
		
		new_bullet_2.set_speed(speed)
		new_bullet_2.set_range(range)
		new_bullet_2.set_damage(damage)
		
		play_sound()
		var distortion = randf_range(-accuracy,accuracy)
		
		new_bullet_1.global_position = $Pivot/Weapon/ShootingPoint1.global_position
		new_bullet_1.global_rotation = $Pivot/Weapon/ShootingPoint1.global_rotation + distortion
		
		new_bullet_2.global_position = $Pivot/Weapon/ShootingPoint2.global_position
		new_bullet_2.global_rotation = $Pivot/Weapon/ShootingPoint2.global_rotation + distortion
		
		owner.add_child(new_bullet_1)
		owner.add_child(new_bullet_2)
		
		reset()

func _on_timer_timeout_duet():
	can_shoot = true

