extends Area2D
signal dead

var health

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_health(health):
	self.health += health

func set_health(health):
	self.health = health

func take_damage(damage):
	health -= damage
	if(health <= 0):
		dead.emit()
