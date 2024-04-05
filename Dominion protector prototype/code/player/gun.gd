class_name Gun

extends Area2D

var can_shoot
var damage = 3
var range = 600
var speed = 600

# this variable will varry the rotation spawn so that it simulates accuracy
var accuracy = .2

const BULLET = preload("res://code/projectiles/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	can_shoot = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# create a bullet at the current viewing angle with a random rotation
func attack():
	if can_shoot:
		var new_bullet = BULLET.instantiate()
		
		new_bullet.set_damage(damage)
		new_bullet.set_speed(speed)
		new_bullet.set_range(range)
		play_sound()
		
		new_bullet.global_position = $Pivot/Weapon/ShootingPoint.global_position
		new_bullet.global_rotation = $Pivot/Weapon/ShootingPoint.global_rotation + randf_range(-accuracy,accuracy)
		
		owner.add_child(new_bullet)
		reset()

func play_sound():
	$AudioStreamPlayer2D.play()

# set the weapon damage
func set_damage(damage):
	self.damage = damage

# reset the timer upon fireing 
func reset():
	can_shoot = false
	$Timer.start()

# disable the functionality and colision of the gun and hide it
func disable():
	can_shoot = false
	$Timer.stop()
	$Pivot/Weapon.hide()

# enable the functionality of the gun and show it
func enable():
	$Timer.start()
	$Pivot/Weapon.show()

func set_accuracy(accuracy):
	self.accuracy = accuracy

func set_range(range):
	self.range = range

func set_speed(speed):
	self.speed = speed

# the cooldown for the interval of player attack
func _on_timer_timeout():
	can_shoot = true
