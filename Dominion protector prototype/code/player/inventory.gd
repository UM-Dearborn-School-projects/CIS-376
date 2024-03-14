extends TextureRect

@export var player : CharacterBody2D
var option

# Called when the node enters the scene tree for the first time.
func _ready():
	option = -1
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("sword")):
		_on_sword_button_pressed()
	elif(Input.is_action_just_pressed("pistol")):
		_on_pistol_button_pressed()
	elif(Input.is_action_just_pressed("smg")):
		_on_smg_button_pressed()
	elif(Input.is_action_just_pressed("duet")):
		_on_duet_button_pressed()
	elif(Input.is_action_just_pressed("shotgun")):
		_on_shotgun_button_pressed()
	elif(Input.is_action_just_pressed("sniper")):
		_on_sniper_button_pressed()
	elif(Input.is_action_just_pressed("rocket")):
		_on_rocket_button_pressed()

func update():
	if player.get_sword():
		$GridContainer/Option1/Sword.show()
	if player.get_pistol():
		$GridContainer/Option2/Pistol.show()
	if player.get_smg():
		$GridContainer/Option3/SMG.show()
	if player.get_duet():
		$GridContainer/Option4/Duet.show()
	if player.get_shotgun():
		$GridContainer/Option5/Shotgun.show()
	if player.get_sniper():
		$GridContainer/Option6/Sniper.show()
	if player.get_rocket():
		$GridContainer/Option7/Rocket.show()

func hide_all():
	$GridContainer/Option1/Sword.hide()
	$GridContainer/Option2/Pistol.hide()
	$GridContainer/Option3/SMG.hide()
	$GridContainer/Option4/Duet.hide()
	$GridContainer/Option5/Shotgun.hide()
	$GridContainer/Option6/Sniper.hide()
	$GridContainer/Option7/Rocket.hide()

func get_option():
	return option

func set_option(option):
	self.option = option

func _on_sword_button_pressed():
	option = 1
	player.set_option(option)

func _on_pistol_button_pressed():
	option = 2
	player.set_option(option)

func _on_smg_button_pressed():
	option = 3
	player.set_option(option)

func _on_duet_button_pressed():
	option = 4
	player.set_option(option)

func _on_shotgun_button_pressed():
	option = 5
	player.set_option(option)

func _on_sniper_button_pressed():
	option = 6
	player.set_option(option)

func _on_rocket_button_pressed():
	option = 7
	player.set_option(option)
