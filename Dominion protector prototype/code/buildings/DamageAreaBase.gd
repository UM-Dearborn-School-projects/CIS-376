extends Area2D
signal dead

"""
This class allows player objects to take damage, this will end the game upon death.
Attach this class to a Area2D object.
"""

# The integer value of the health amount
var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Increases the health by a given value
func add_health(health):
	self.health += health
	if health > 100:
		health = 100
	update()

# Set the health to a specific value
func set_health(health):
	self.health = health
	update()

# Decrement the health by a given amount
func take_damage(damage):
	health -= damage
	update()
	if(health <= 0):
		dead.emit()

func update():
	%BaseHealth.text = str(health) + "/100"

func get_count():
	return get_parent().get_count()
