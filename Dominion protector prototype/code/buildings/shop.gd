extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start():
	$ShopArea.reset()
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("move")

func stop():
	$ShopArea.reset()
	$AnimatedSprite2D.hide()
	$AnimatedSprite2D.stop()
