extends StaticBody2D
signal dead

@export var player : CharacterBody2D
@export var save : Node

var damage = 5

var id = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	set_damage()
	stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# enable functionality
func start(position):
	self.position = position
	$DamageArea.set_health(100)
	show()
	$CanvasLayer.show()
	$Turet.reset()
	$CollisionShape2D.disabled = false

# disable functionality
func stop():
	hide() 
	$CanvasLayer.hide()
	$Turet.disable()
	# disable the colision detection so that it will not triger more than once
	$CollisionShape2D.set_deferred("disabled", true)

func add_damage():
	damage = damage * 2
	set_damage()

func set_damage():
	$Turet.set_damage(damage)

func add_speed():
	$Turet.reduce_timer()

func add_health(amount):
	$DamageArea.add_health(amount)

# End game condition
func _on_damage_area_dead():
	dead.emit()

# Returns an instance of player
func get_player():
	return player

# Returns an instance of the save script
func get_save():
	return save

func get_count():
	return id
