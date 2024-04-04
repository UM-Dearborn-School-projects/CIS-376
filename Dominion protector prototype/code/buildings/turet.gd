extends Area2D

var can_shoot
var damage = 10
var mob_array = []
var clean_array = []
var target_enemy

const BULLET = preload("res://code/projectiles/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	can_shoot = false

# also called every frame?
func _physics_process(delta):
	detect_mobs()
	target()

func set_damage(damage):
	self.damage = damage

# Find the closest enemy
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
	var new_bullet = BULLET.instantiate()
	new_bullet.set_damage(damage)
	new_bullet.global_position = %ShootingPoint.global_position
	%ShootingPoint.add_child(new_bullet)

# Start timers for reload
func start_timer():
	$ShootingTimer.start()
	$AnimationTimer.start()

func reduce_timer():
	$ShootingTimer.set_wait_time(2)

# Reset the functionality
func reset():
	can_shoot = false
	$ShootingTimer.start()

# Disable the functionality
func disable():
	can_shoot = false
	$ShootingTimer.stop()

# Allowed to shoort after reload
func _on_timer_timeout():
	can_shoot = true

# will update the mob arrays with the entered bodies
func detect_mobs():
	for mob in mob_array:
		if is_instance_valid(mob):
			clean_array.append(mob)
	
	mob_array.clear()
	
	for mob in clean_array:
		mob_array.append(mob)
	
	clean_array.clear()
	
	if mob_array.size() > 0:
		var current_position = position
		var max_dif = 999999
		var diffrance 
		var flag
		
		for i in mob_array.size():
			diffrance = current_position.distance_to(mob_array[i].position)
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
