extends Area2D

class_name Bullet

var travelled_distance = 0
var speed = 900
var range = 900
var damage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# bullet movement
func _physics_process(delta):
	# gives the direction in which the pointer is aiming at
	var direction = Vector2.RIGHT.rotated(rotation)
	# updates the movement and travel distance
	position += direction * speed * delta
	travelled_distance += speed * delta
	# removes if out of range
	if(travelled_distance > range):
		queue_free()

# set the bullet damage
func set_damage(damage):
	self.damage = damage

# the range of the bullet travel
func set_range(range):
	self.range = range

# the speed at which the bullet moves
func set_speed(speed):
	self.speed = speed

# deal damage to enemy and disapear
func _on_body_entered(body):
	queue_free()
	if body.has_method("enemy_take_damage"):
		body.enemy_take_damage(damage)

