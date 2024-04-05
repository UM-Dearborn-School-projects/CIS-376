extends Area2D

"""
This class gives functionality to the shop buttons and allows them to show 
when a player colides with a colision shape. 
"""

# Save script
var save : Node
# player instance
var player : CharacterBody2D
var base : StaticBody2D
var state

#cost of items can be adjusted here
var pistol_cost = 150
var smg_cost = 300
var duet_cost = 300
var shotgun_cost = 600
var sniper_cost = 800
var rocket_cost = 1500

var health_cost = 50
var health_amount = 5

var base_health_cost = 200
var base_health_amount = 10

var speed_cost = 200
var speed_amount = 10

var damage_cost = 500
var atack_speed_cost = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Main/PlayerObjects/Player")
	base = get_node("/root/Main/PlayerObjects/Base")
	save = get_node("/root/Main/SaverLoader")
	state = 0
	hide_all()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#hides all icons
func hide_all():
	$Shop.hide()
	$Shop/ShopOptions.hide()
	$Shop/ShopOptions/Weapons.hide()
	$Shop/ShopOptions/Utility.hide()
	$Shop/ShopOptions/Upgrades.hide()
	$Shop/ShopOptions/SaveButton.hide()
	$Shop/ShopOptions/LoadButton.hide()

#checks to see if the player has enough money to make a purchase
func has_money(amount):
	if player.get_money() >= amount:
		return true
	return false

func reduce_money(amount):
	player.reduce_money(amount)

# show the shop when the player is near
func _on_area_entered(area):
	if area.is_in_group("player"):
		hide_all()
		$Shop.show()
		$Shop/ShopButton.show()
		$Shop/BackButton.hide()
		$Shop/ShopOptions/LoadButton.show()
		$Shop/ShopOptions/SaveButton.show()
		state = 0

# close the shop when the player is far
func _on_area_exited(area):
	if area.is_in_group("player"):
		hide_all()
		state = -1

# Reveal top level of the shop branch
func _on_shop_button_pressed():
	state = 1
	$Shop/ShopButton.hide()
	$Shop/BackButton.show()
	$Shop/ShopOptions.show()

# Reveal the upgrades shop brach
func _on_upgrade_button_pressed():
	state = 2
	$Shop/ShopOptions.hide()
	$Shop/ShopOptions/Upgrades.show()

# Reveal the utility shop brach
func _on_utility_button_pressed():
	state = 2
	$Shop/ShopOptions.hide()
	$Shop/ShopOptions/Utility.show()

# Reveal the weapon shop brach
func _on_weapon_button_pressed():
	state = 2
	$Shop/ShopOptions.hide()
	$Shop/ShopOptions/Weapons.show()

# Go back one branch
func _on_back_button_pressed():
	hide_all()
	
	print(state)
	
	if state == 1:
		state = 0
		$Shop.show()
		$Shop/BackButton.hide()
		$Shop/ShopButton.show()
	elif state == 2 :
		state = 1
		$Shop.show()
		$Shop/BackButton.show()
		$Shop/ShopButton.hide()
		$Shop/ShopOptions.show()

# purchase the pistol
func _on_pistol_button_pressed():
	if(has_money(pistol_cost)):
		reduce_money(pistol_cost)
		$Shop/ShopOptions/Weapons/PistolButton.disabled = true
		player.set_pistol(true)

# purchase the smg
func _on_smg_button_pressed():
	if(has_money(smg_cost)):
		reduce_money(smg_cost)
		$Shop/ShopOptions/Weapons/SMGButton.disabled = true
		player.set_smg(true)

# purchase the duet
func _on_duet_button_pressed():
	if(has_money(duet_cost)):
		reduce_money(duet_cost)
		$Shop/ShopOptions/Weapons/DuetButton.disabled = true
		player.set_duet(true)

# purchase the shotgun
func _on_shotgun_button_pressed():
	if(has_money(shotgun_cost)):
		reduce_money(shotgun_cost)
		$Shop/ShopOptions/Weapons/ShotgunButton.disabled = true
		player.set_shotgun(true)

# purchase the sniper
func _on_sniper_button_pressed():
	if(has_money(sniper_cost)):
		reduce_money(sniper_cost)
		$Shop/ShopOptions/Weapons/SniperButton.disabled = true
		player.set_sniper(true)

# purchase the rocket
func _on_rocket_button_pressed():
	if(has_money(rocket_cost)):
		reduce_money(rocket_cost)
		$Shop/ShopOptions/Weapons/RocketButton.disabled = true
		player.set_rocket(true)

# purchase health
func _on_health_button_pressed():
	if(has_money(health_cost)):
		reduce_money(health_cost)
		player.add_health(health_amount)

# purchase speed
func _on_speed_button_pressed():
	if(has_money(speed_cost)):
		reduce_money(speed_cost)
		player.add_speed(speed_amount)

# Load the game
func _on_load_button_pressed():
	print("Load game")
	save.load_game() 

# Save the game
func _on_save_button_pressed():
	print("Save game")
	save.save_game()

# increase base damage by doble
func _on_base_damage_pressed():
	if(has_money(damage_cost)):
		reduce_money(damage_cost)
		base.add_damage()
		$Shop/ShopOptions/Upgrades/BaseDamage.disabled = true

# increase base attack speed by tripple
func _on_base_atk_spd_pressed():
	if(has_money(atack_speed_cost)):
		reduce_money(atack_speed_cost)
		base.add_speed()
		$Shop/ShopOptions/Upgrades/BaseAtkSpd.disabled = true

# heal base by 10
func _on_base_health_button_pressed():
	if(has_money(base_health_cost)):
		reduce_money(base_health_cost)
		base.add_health(base_health_amount)
