extends Area2D

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

func attack():
	if(can_shoot):
		can_shoot = false
		$CollisionShape2D.disabled = false
		animation.play("attack")
		$Timer.start()
		$AnimationTimer.start()

func disable():
	$Timer.stop()
	$AnimationTimer.stop()
	$CollisionShape2D.disabled = true
	can_shoot = false
	$CollisionShape2D/Sword.hide()

func enable():
	can_shoot = true
	$CollisionShape2D/Sword.show()

func _on_timer_timeout():
	can_shoot = true

func _on_body_entered(body):
	if body.has_method("enemy_take_damage"):
		body.enemy_take_damage(damage)


func _on_animation_timer_timeout():
	animation.play("RESET")
