extends Area2D

var save : Node

var player : CharacterBody2D
var state

#cost of items can be adjusted here
var pistol_cost = 100


var health_cost = 50
var health_amount = 5

var speed_cost = 200
var speed_amount = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_player()
	save = get_parent().get_save()
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

func _on_shop_button_pressed():
	state = 1
	$Shop/ShopButton.hide()
	$Shop/BackButton.show()
	$Shop/ShopOptions.show()
	


func _on_upgrade_button_pressed():
	state = 2
	$Shop/ShopOptions.hide()
	$Shop/ShopOptions/Upgrades.show()


func _on_utility_button_pressed():
	state = 2
	$Shop/ShopOptions.hide()
	$Shop/ShopOptions/Utility.show()


func _on_weapon_button_pressed():
	state = 2
	$Shop/ShopOptions.hide()
	$Shop/ShopOptions/Weapons.show()


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


func _on_pistol_button_pressed():
	if(has_money(pistol_cost)):
		reduce_money(pistol_cost)
		$Shop/ShopOptions/Weapons/PistolButton.disabled = true
		player.set_pistol(true)


func _on_smg_button_pressed():
	pass # Replace with function body.


func _on_duet_button_pressed():
	pass # Replace with function body.


func _on_shotgun_button_pressed():
	pass # Replace with function body.


func _on_sniper_button_pressed():
	pass # Replace with function body.


func _on_rocket_button_pressed():
	pass # Replace with function body.


func _on_health_button_pressed():
	if(has_money(health_cost)):
		reduce_money(health_cost)
		player.add_health(health_amount)


func _on_speed_button_pressed():
	if(has_money(speed_cost)):
		reduce_money(speed_cost)
		player.add_speed(speed_amount)
		



func _on_load_button_pressed():
	print("Load game")
	save.load_game() 


func _on_save_button_pressed():
	print("Save game")
	save.save_game()
