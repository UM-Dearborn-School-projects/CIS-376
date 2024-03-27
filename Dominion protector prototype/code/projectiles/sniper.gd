extends Gun


# Called when the node enters the scene tree for the first time.
func _ready():
	set_damage(20)
	set_accuracy(0.01)
	set_range(1200.0)
	set_speed(1000.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout_sniper():
	can_shoot = true
