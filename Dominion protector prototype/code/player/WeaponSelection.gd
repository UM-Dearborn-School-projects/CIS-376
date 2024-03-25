extends Node2D

"""
This class manages player weapon selection, more specificly which weapon
is currently being used and which weapon will be attacking. It requires the
player to already have the weapon and checks this by making a call to the player get{weapons}
functions when switching weapons.
"""

@export var player : CharacterBody2D
var option
var previous
var mouse_position

# Called when the node enters the scene tree for the first time.
func _ready():
	option = -1
	previous = -1
	disable_all()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	
	option = player.get_option()
	
	if (previous != option):
		disable(previous)
		enable(option)
		previous = option
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		attack(option)

# disable all weapons and hide them
func disable_all():
	$Sword.disable()
	$Gun.disable()

# attack using the current weapon that the player has selected
func attack(option):
	if option == 1 && player.get_sword():
		$Sword.attack()
	elif option == 2 && player.get_pistol():
		$Gun.attack()
	elif option == 3:
		pass
	elif option == 4:
		pass
	elif option == 5:
		pass
	elif option == 6:
		pass
	elif option == 7:
		pass

# disable a single weapon given a numeric option (1-7)
func disable(option):
	if option == 1:
		$Sword.disable()
	elif option == 2:
		$Gun.disable()
	elif option == 3:
		pass
	elif option == 4:
		pass
	elif option == 5:
		pass
	elif option == 6:
		pass
	elif option == 7:
		pass

# enable a single weapon given a numeric option (1-7)
func enable(option):
	if option == 1 && player.get_sword():
		$Sword.enable()
	elif option == 2 && player.get_pistol():
		$Gun.enable()
	elif option == 3:
		pass
	elif option == 4:
		pass
	elif option == 5:
		pass
	elif option == 6:
		pass
	elif option == 7:
		pass
