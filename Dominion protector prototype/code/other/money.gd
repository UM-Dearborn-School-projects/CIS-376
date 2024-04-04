extends Area2D

var amount
var player
var entered
var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Main/PlayerObjects/Player")
	entered = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(entered):
		var direction = global_position.direction_to(player.global_position)
		var new_position = position + (direction * speed * delta)
		self.set_position(new_position)

func get_value():
	return amount

func set_value(amount):
	self.amount = amount

# deletes the money after a certin time (disabled)
func _on_timer_timeout():
	#queue_free()
	pass

func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		entered = true
