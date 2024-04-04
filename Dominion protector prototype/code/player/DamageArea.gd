extends Area2D
signal dead

var health = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# increase health by this amount
func add_health(health):
	self.health += health
	if(self.health >= 20):
		self.health = 20
	update()

func set_health(health):
	self.health = health
	update()

# remove health by this amount
func take_damage(damage):
	$AudioStreamPlayer2D.play()
	health -= damage
	update()
	if(health <= 0):
		dead.emit()

func get_health():
	return health

func update():
	%Health.text = str(self.health) + "/20"
