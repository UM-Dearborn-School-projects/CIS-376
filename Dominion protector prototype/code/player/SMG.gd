extends Gun

# Called when the node enters the scene tree for the first time.
func _ready():
	set_damage(1)
	set_accuracy(.3)
	set_range(700)
	set_speed(700)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Reload time
func _on_timer_timeout_smg():
	can_shoot = true
