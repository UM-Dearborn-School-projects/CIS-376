extends Bullet

# Called when the node enters the scene tree for the first time.
func _ready():
	$Explosion/ExplosionStart.disabled = true
	$Explosion/ExplosionEnd.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered_missile(body):
	$MissilePic.hide()
	speed = 50
	
	$AudioStreamPlayer2D.play()
	$AnimatedSprite2D.play("boom")
	$AnimationPlayer.play("boom")
	await get_tree().create_timer(.5).timeout
	
	queue_free()


func _on_Explosion_body_entered(body):
	if body.has_method("enemy_take_damage"):
		body.enemy_take_damage(damage)
