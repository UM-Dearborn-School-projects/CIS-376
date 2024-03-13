extends CanvasLayer
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_message(text):
	$Title.text = text
	$Title.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout
	# change the message
	$Title.text = "Dominion Protector"
	$Title.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()


func _on_start_button_pressed():
	$StartButton.hide()
	$loadButton.hide()
	$saveButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Title.hide()
