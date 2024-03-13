extends StaticBody2D
signal dead

@export var player : CharacterBody2D
@export var save : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# enable functionality
func start(position):
	self.position = position
	$DamageArea.set_health(100)
	show()
	$Turet.reset()
	$CollisionShape2D.disabled = false

# disable functionality
func stop():
	hide() 
	$Turet.disable()
	# disable the colision detection so that it will not triger more than once
	$CollisionShape2D.set_deferred("disabled", true)

func get_player():
	return player

func _on_damage_area_dead():
	dead.emit()

func get_savetest():
		return save
