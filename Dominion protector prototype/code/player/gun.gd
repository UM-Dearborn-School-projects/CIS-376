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

func reset():
	can_shoot = false
	$Timer.start()

func disable():
	can_shoot = false
	$Timer.stop()
	$Pivot/gun1.hide()

func enable():
	$Timer.start()
	$Pivot/gun1.show()

func _on_timer_timeout():
	can_shoot = true
