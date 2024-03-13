extends TextureRect

var option

# Called when the node enters the scene tree for the first time.
func _ready():
	option = -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("sword")):
		option = 1
	elif(Input.is_action_just_pressed("pistol")):
		option = 2
	elif(Input.is_action_just_pressed("smg")):
		option = 3
	elif(Input.is_action_just_pressed("duet")):
		option = 4
	elif(Input.is_action_just_pressed("shotgun")):
		option = 5
	elif(Input.is_action_just_pressed("sniper")):
		option = 6
	elif(Input.is_action_just_pressed("rocket")):
		option = 7

func get_option():
	return option

func set_option(option):
	self.option = option

func _on_sword_button_pressed():
	option = 1


func _on_pistol_button_pressed():
	option = 2


func _on_smg_button_pressed():
	option = 3


func _on_duet_button_pressed():
	option = 4


func _on_shotgun_button_pressed():
	option = 5


func _on_sniper_button_pressed():
	option = 6


func _on_rocket_button_pressed():
	option = 7
