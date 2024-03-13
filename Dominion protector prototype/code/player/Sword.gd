extends Area2D

var damage
var mouse_position
var sword_roation
var max_rotation
var rotation_rate

# Called when the node enters the scene tree for the first time.
func _ready():
	sword_roation = rotation_degrees
	max_rotation = 30
	rotation_rate = 5
	mouse_position = null
	damage = 4
	$CollisionShape2D.set_deferred("disabled", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse_position = get_global_mouse_position()
	look_at(mouse_position)

func attack():
	$CollisionShape2D.disabled = false
	if rotation <= rotation:
		rotation_degrees -= rotation_rate
	
	rotation = sword_roation


func _on_timer_timeout():
	attack()
