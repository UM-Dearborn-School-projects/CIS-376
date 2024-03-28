extends Bullet


# Called when the node enters the scene tree for the first time.
func _ready():
	range = 300
	speed = 250
	damage = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.is_in_group("player"):
		area.take_damage(damage)
	elif area.is_in_group("base"):
		area.take_damage(damage)
	
	queue_free()
