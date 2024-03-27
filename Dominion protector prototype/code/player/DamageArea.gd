extends Area2D
signal dead

var health = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	%Health.text = str(health) + "/20"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# increase health by this amount
func add_health(health):
	self.health += health
	if(self.health >= 20):
		self.health = 20
	%Health.text = str(self.health) + "/20"

func set_health(health):
	self.health = health
	%Health.text = str(health) + "/20"

# remove health by this amount
func take_damage(damage):
	$AudioStreamPlayer2D.play()
	health -= damage
	%Health.text = str(health) + "/20"
	if(health <= 0):
		dead.emit()
