extends CharacterBody2D
signal dead

var savePosition : Vector2

var speed = 200
var health = 10;
var screen_size
var money
var option

var sword
var pistol
var smg
var duet
var shotgun
var sniper
var rocket

signal update_inv

func _ready():
	sword = true
	pistol = false
	smg = false
	duet = false
	shotgun = false
	sniper= false
	rocket = false
	
	option = 0;
	
	screen_size = get_viewport_rect().size
	#position = get_viewport_rect().get_center()
	money = 0
	stop()

func _physics_process(delta):
	movement(delta)
	update()

func movement(delta):
	# check for player input
	var direction = Input.get_vector("move_left", "move_right", "move_up","move_down")
	velocity = direction * speed
	
	# normalize player movement to prevent fast horizontal movement
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	velocity = velocity.normalized() * speed
	move_and_slide()
	
	# flip the animation based on the direction movement
	$AnimatedSprite2D.flip_v = false
	$AnimatedSprite2D.flip_h = velocity.x < 0
	$AnimatedSprite2D.flip_v = velocity.y > 0
	
	# update the position value and prevent it from leaving the screen
	# delta refers to the frame rate and thus standardizes movement across frame rates
	position += velocity * delta 
	position = position.clamp(Vector2.ZERO, screen_size)

func _on_area_2d_area_entered(area):
	if area.is_in_group("coin"):
		money += area.get_value()
		area.queue_free()

func dead_signal():
	dead.emit()

# enable functionality
func start(position):
	$DamageArea.set_health(10)
	self.position = position
	show()
	$CanvasLayer.show()
	$CollisionShape2D.disabled = false
	$DamageArea/CollisionShape2D.disabled = false

# disable functionality
func stop():
	hide()
	$CanvasLayer.hide()
	# disable the colision detection so that it will not triger more than once
	$CollisionShape2D.set_deferred("disabled", true)
	$DamageArea/CollisionShape2D.set_deferred("disabled", true)

func update():
	$CanvasLayer/MoneyCounter.text = str(money)

func reduce_money(amount):
	money -= amount
	update()

func change_health(amount):
	health = amount

func add_health(amount):
	$DamageArea.add_health(amount)

func set_health(amount):
	$DamageArea.set_health(amount)

func add_speed(amount):
	speed += amount

#region Getters and setters for guns
#	This section is about getting the truth values of the weapons in inventory
func get_money():
	return money

func get_option():
	return option

func set_option(option):
	self.option = option

func get_sword():
	return sword

func set_sword(val: bool):
	sword = val
	update_inv.emit()

func get_pistol():
	return pistol

func set_pistol(val: bool):
	pistol = val
	update_inv.emit()

func get_smg():
	return smg

func set_smg(val: bool):
	smg = val
	update_inv.emit()

func get_duet():
	return duet

func set_duet(val: bool):
	duet = val
	update_inv.emit()

func get_shotgun():
	return shotgun

func set_shotgun(val: bool):
	shotgun = val
	update_inv.emit()

func get_sniper():
	return sniper

func set_sniper(val: bool):
	sniper = val
	update_inv.emit()

func get_rocket():
	return rocket

func set_rocket(val: bool):
	rocket = val
	update_inv.emit()
#endregion
