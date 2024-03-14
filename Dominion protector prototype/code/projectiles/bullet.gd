extends Area2D

var travelled_distance = 0
const SPEED = 900
const RANGE = 900
var damage = 2

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
	position += direction * SPEED * delta
	travelled_distance += SPEED * delta
	# removes if out of range
	if(travelled_distance > RANGE):
		queue_free()

func set_damage(damage):
	self.damage = damage

func _on_body_entered(body):
	queue_free()
	if body.has_method("enemy_take_damage"):
		body.enemy_take_damage(damage)
