extends Area2D
signal dead

var health = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_health(health):
	self.health += health
	%Health.text = str(self.health)

func set_health(health):
	self.health = health
	%Health.text = str(health)

func take_damage(damage):
	health -= damage
	%Health.text = str(health)
	if(health <= 0):
		dead.emit()
