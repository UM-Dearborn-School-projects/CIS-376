extends Bullet

# Called when the node enters the scene tree for the first time.
func _ready():
	range = 300
	speed = 250
	damage = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	# gives the direction in which the pointer is aiming at
	var direction = Vector2.RIGHT.rotated(rotation)
	# updates the movement and travel distance
	position += direction * speed * delta
	travelled_distance += speed * delta
	# removes if out of range
	if(travelled_distance > range):
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("player"):
		area.take_damage(damage)
	elif area.is_in_group("base"):
		area.take_damage(damage)
	
	queue_free()
