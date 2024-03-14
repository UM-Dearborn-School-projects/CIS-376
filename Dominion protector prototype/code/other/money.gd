extends Area2D

var amount

# Called when the node enters the scene tree for the first time.
func _ready():
	amount = 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_value():
	return amount

func set_value(value):
	amount = value
