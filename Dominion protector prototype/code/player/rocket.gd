extends Gun

const MISSILE = preload("res://code/projectiles/missile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_damage(4)
	set_accuracy(.1)
	set_range(900)
	set_speed(700)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# create a misile at the current viewing angle with a random rotation
func attack():
	if can_shoot:
		var new_missile = MISSILE.instantiate()
		
		new_missile.set_damage(damage)
		new_missile.set_range(range)
		new_missile.set_speed(speed)
		play_sound()
		
		new_missile.global_position = $Pivot/Weapon/ShootingPoint.global_position
		new_missile.global_rotation = $Pivot/Weapon/ShootingPoint.global_rotation + randf_range(-accuracy,accuracy)
		
		owner.add_child(new_missile)
		reset()

func _on_timer_timeout_rocket():
	can_shoot = true
