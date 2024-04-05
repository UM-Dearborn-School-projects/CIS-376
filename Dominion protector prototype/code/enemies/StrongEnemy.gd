extends Mob


# Called when the node enters the scene tree for the first time.
func _ready():
	start()

func start():
	$Laser.hide()
	$AnimatedSprite2D.play("Idle")
	await get_tree().create_timer(.5).timeout
	
	enter = true
	
	count += 1
	current_count = count
	player = get_node("/root/Main/PlayerObjects/Player")
	base = get_node("/root/Main/PlayerObjects/Base")
	main = get_node("/root/Main")
	speed = 125
	health = 12
	damage = 2
	$Laser.set_damage(damage)
	money_value = 50
	player_range = 125
	base_range = 125
