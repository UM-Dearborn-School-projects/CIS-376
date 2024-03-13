extends "res://code/enemies/mob.gd"

func _ready():
	speed = 200
	health = 6
	damage = 2
	# create an animation type array and chose one randomly
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	# randi() % n selects a random integer between 0 and n-1
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])


