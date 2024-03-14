extends Node2D

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

func disable_all():
	$Sword.disable()
	$Gun.disable()

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
