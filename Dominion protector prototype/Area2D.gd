extends Area2D

var amount

# Called when the node enters the scene tree for the first time.
func _ready():
	amount = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_amount():
	return amount

func set_amount(value):
	amount = value


func _on_body_entered(body):
	queue_free()
