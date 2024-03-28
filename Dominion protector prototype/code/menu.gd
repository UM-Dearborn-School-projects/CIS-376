extends CanvasLayer
signal start_game

"""
This class displayes the menu at the begining of the game and upon player death
"""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# displays a message given a String text
func show_message(text):
	$Title.text = text
	$Title.show()
	$MessageTimer.start()

# displayes the game over message and then returns to menu after a short time
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

# start the game
func _on_start_button_pressed():
	$StartButton.hide()
	$QuitButton.hide() # hides quit from showing when game starts
	$TutorialButton.hide() # hides the tutorial button when games starts
	start_game.emit()

func _on_message_timer_timeout():
	$Title.hide()


func _on_quit_button_pressed():
	get_tree().quit() # should quit the game when the button is pressed
