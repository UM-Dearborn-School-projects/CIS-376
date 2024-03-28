extends Area2D

var amount

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_value():
	return amount

func set_value(amount):
	self.amount = amount

# deletes the money after a certin time (disabled)
func _on_timer_timeout():
	#queue_free()
	pass
