extends CharacterBody2D
signal dead

var speed = 200.0
var health = 100
var money = 0

var savePosition : Vector2

var screen_size

var sword
var pistol
var smg
var duet
var shotgun
var sniper
var rocket
var stats



func _ready():
	sword = true
	pistol = false
	smg = false
	duet = false
	shotgun = false
	sniper= false
	rocket = false
	
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
	move_and_slide()
	
	# normalize player movement to prevent fast horizontal movement
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	# flip the animation based on the direction movement
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		
		#$AnimatedSprite2D.flip_h = velocity.x  < 0
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	
	elif  velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		
		#$AnimatedSprite2D.flip_v = velocity.y < 0
		if velocity.y < 0:
			$AnimatedSprite2D.flip_v = false
		else:
			$AnimatedSprite2D.flip_v = true
	
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
	$DamageArea.set_health(100)
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

func get_money():
	return money

func reduce_money(amount):
	money -= amount
	update()

func add_health(amount):
	$DamageArea.add_health(amount)
	

func set_health(amount):
	$DamageArea.set_health(amount)

func add_speed(speed):
	self.speed += speed
	
#region Getters and setters for guns
#	This section is about getting the truth values of the weapons in inventory
func get_sword():
	return sword

func set_sword(val: bool):
	sword = val

func get_pistol():
	return pistol

func set_pistol(val: bool):
	pistol = val

func get_smg():
	return smg

func set_smg(val: bool):
	smg = val

func get_duet():
	return duet

func set_duet(val: bool):
	duet = val

func get_shotgun():
	return shotgun

func set_shotgun(val: bool):
	shotgun = val

func get_sniper():
	return sniper

func set_sniper(val: bool):
	sniper = val

func get_rocket():
	return rocket

func set_rocket(val: bool):
	rocket = val
#endregion

