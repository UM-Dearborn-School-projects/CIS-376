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
var reset

# Called when the node enters the scene tree for the first time.
func _ready():
	var reset = false
	option = -1
	previous = -1
	disable_all()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	
	var mouseLocFromPlayer = get_global_mouse_position() - self.position
	
	var angle = atan2(mouseLocFromPlayer.y, mouseLocFromPlayer.x)
	
	if mouseLocFromPlayer.x < -10:
		scale.x = -1
	elif mouseLocFromPlayer.x >= 10:
		scale.x = 1
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		attack(option)

func get_option():
	return option

# allow players to select and deselect weapons
func set_option(option):
	self.option = option
	
	if previous != option:
		disable(previous)
		enable(option)
		previous = option
		reset = true
	else:
		if reset == true:
			disable(option)
		else:
			enable(option)
		
		reset = !reset

# disable all weapons and hide them
func disable_all():
	$Sword.disable()
	$Gun.disable()
	$SMG.disable()
	$Duet.disable()
	$Shotgun.disable()
	$Sniper.disable()
	$Rocket.disable()

# attack using the current weapon that the player has selected
func attack(option):
	if option == 1 && player.get_sword():
		$Sword.attack()
	elif option == 2 && player.get_pistol():
		$Gun.attack()
	elif option == 3 && player.get_smg():
		$SMG.attack()
	elif option == 4 && player.get_duet():
		$Duet.attack()
	elif option == 5 && player.get_shotgun():
		$Shotgun.attack()
	elif option == 6 && player.get_sniper():
		$Sniper.attack()
	elif option == 7 && player.get_rocket():
		$Rocket.attack()

# disable a single weapon given a numeric option (1-7)
func disable(option):
	if option == 1:
		$Sword.disable()
	elif option == 2:
		$Gun.disable()
	elif option == 3:
		$SMG.disable()
	elif option == 4:
		$Duet.disable()
	elif option == 5:
		$Shotgun.disable()
	elif option == 6:
		$Sniper.disable()
	elif option == 7:
		$Rocket.disable()

# enable a single weapon given a numeric option (1-7)
func enable(option):
	if option == 1 && player.get_sword():
		$Sword.enable()
	elif option == 2 && player.get_pistol():
		$Gun.enable()
	elif option == 3 && player.get_smg():
		$SMG.enable()
	elif option == 4 && player.get_duet():
		$Duet.enable()
	elif option == 5 && player.get_shotgun():
		$Shotgun.enable()
	elif option == 6 && player.get_sniper():
		$Sniper.enable()
	elif option == 7 && player.get_rocket():
		$Rocket.enable()
