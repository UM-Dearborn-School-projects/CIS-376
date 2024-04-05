extends Area2D

"""
This class gives functionality to the enemy sword and controls the animaation 
"""

var damage
var can_shoot
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Main/PlayerObjects/Player")
	damage = 2
	can_shoot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func attack(node):
	var direction = global_position.direction_to(node.global_position)
	if(can_shoot):
		look_at(node.global_position)
		can_shoot = false
		$CollisionShape2D/Sprite2D.show()
		$CollisionShape2D.disabled = false
		$AnimationPlayer.play("attack")
		reset()

func set_damage(amount):
	self.damage = damage

func reset():
	can_shoot = false
	$Timer.start()
	$AnimationTimer.start()

func _on_area_entered(area):
	if area.is_in_group("player"):
		area.take_damage(damage)
		$CollisionShape2D.disabled = true
		#await get_tree().create_timer(2).timeout
	elif area.is_in_group("base"):
		area.take_damage(damage)


func _on_timer_timeout():
	can_shoot = true


func _on_animation_timer_timeout():
	$AnimationPlayer.play("RESET")
	$CollisionShape2D/Sprite2D.hide()
