extends Area2D

var can_shoot

# Called when the node enters the scene tree for the first time.
func _ready():
	can_shoot = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func attack():
	if can_shoot:
		const BULLET = preload("res://code/projectiles/bullet.tscn")
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %ShootingPoint.global_position
		new_bullet.global_rotation = %ShootingPoint.global_rotation
		%ShootingPoint.add_child(new_bullet)
		reset()

# reset the timer upon fireing 
func reset():
	can_shoot = false
	$Timer.start()

# disable the functionality and colision of the gun and hide it
func disable():
	can_shoot = false
	$Timer.stop()
	$Pivot/gun1.hide()

# enable the functionality of the gun and show it
func enable():
	$Timer.start()
	$Pivot/gun1.show()

# the cooldown for the interval of player attack
func _on_timer_timeout():
	can_shoot = true
