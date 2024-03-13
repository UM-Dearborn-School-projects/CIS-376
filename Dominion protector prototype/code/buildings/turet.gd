extends Area2D

var can_shoot
var damage = 10
var mob_array = []
var clean_array = []
var target_enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	can_shoot = false

# also called every frame?
func _physics_process(delta):
	detect_mobs()
	target()

func target():
	if(target_enemy != null):
		look_at(target_enemy.global_position)
		if(can_shoot and mob_array.size() > 0):
			shoot()
			can_shoot = false
			start_timer()

# shoot a bullet
func shoot():
	$Pivot/AnimatedSprite2D.animation = "attack"
	const BULLET = preload("res://code/projectiles/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.set_damage(damage)
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)

func start_timer():
	$ShootingTimer.start()
	$AnimationTimer.start()

func reset():
	can_shoot = false
	$ShootingTimer.start()

func disable():
	can_shoot = false
	$ShootingTimer.stop()

func _on_timer_timeout():
	can_shoot = true

# will update the mob arrays with the entered bodies
func detect_mobs():
	for mob in mob_array:
		if is_instance_valid(mob):
			clean_array.append(mob)
	
	mob_array.clear()
	
	for mob in clean_array:
		if is_instance_valid(mob):
			mob_array.append(mob)
	
	clean_array.clear()
	
	if mob_array.size() > 0:
		var current_position = position
		var max_dif = 999999
		var diffrance 
		var i = 0
		var flag = 0  
		
		for mob in mob_array:
			diffrance = current_position.distance_to(mob.position)
			if(diffrance < max_dif):
				max_dif = diffrance
				flag = i
			i += 1
		
		target_enemy = mob_array[flag]

# disable animation
func _on_animation_timer_timeout():
	$Pivot/AnimatedSprite2D.animation = "defult"

# select enemies when they enter the range
func _on_body_entered(body):
	if body.is_in_group("mob"):
		mob_array.append(body)

# deselect the enemies when they exit the range
func _on_body_exited(body):
	if body.is_in_group("mob"):
		var count = body.get_count()
		var i = 0
		for mob in mob_array:
			if count == mob.get_count():
				if mob_array[i] == target_enemy:
					target_enemy = null
				mob_array.remove_at(i)
			i += 1
