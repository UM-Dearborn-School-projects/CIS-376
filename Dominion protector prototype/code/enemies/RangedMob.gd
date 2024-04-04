extends Mob

func _ready():
	start()

func start():
	
	$AnimatedSprite2D.play("Idle")
	await get_tree().create_timer(.75).timeout
	
	enter = true
	
	count += 1
	current_count = count
	player = get_node("/root/Main/PlayerObjects/Player")
	base = get_node("/root/Main/PlayerObjects/Base")
	main = get_node("/root/Main")
	speed = 50
	health = 6
	damage = 2

func _physics_process(delta):
	pass
