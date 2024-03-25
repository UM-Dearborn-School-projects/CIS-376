extends Area2D

"""
This class gives functionality to the player sword and controls the animaation 
"""

var damage
var can_shoot
var animation

# Called when the node enters the scene tree for the first time.
func _ready():
	can_shoot =false
	damage = 4
	animation = $AnimationPlayer
	disable()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# perform an attack with the sword by playing the animation and enabling the colision. 
# The animation then disables the colision at the end.
func attack():
	if(can_shoot):
		can_shoot = false
		$CollisionShape2D.disabled = false
		animation.play("attack")
		reset()

# reset the timer upon fireing 
func reset():
	can_shoot = false
	$Timer.start()
	$AnimationTimer.start()

# disable the functionality and colision of the sword and hide it
func disable():
	$Timer.stop()
	$AnimationTimer.stop()
	$CollisionShape2D.disabled = true
	can_shoot = false
	$CollisionShape2D/Sword.hide()

# enable the functionality of the sword and show it
func enable():
	can_shoot = true
	$CollisionShape2D/Sword.show()

# the cooldown for the interval of player attack
func _on_timer_timeout():
	can_shoot = true

func _on_animation_timer_timeout():
	animation.play("RESET")

# when the sword makes contact with an enemy
func _on_body_entered(body):
	if body.has_method("enemy_take_damage"):
		body.enemy_take_damage(damage)

