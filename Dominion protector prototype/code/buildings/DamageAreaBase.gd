extends Area2D
signal dead

"""
This class allows player objects to take damage, this will end the game upon death.
Attach this class to a Area2D object.
"""

# The integer value of the health amount
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Increases the health by a given value
func add_health(health):
	self.health += health

# Set the health to a specific value
func set_health(health):
	self.health = health

# Decrement the health by a given amount
func take_damage(damage):
	health -= damage
	if(health <= 0):
		dead.emit()
