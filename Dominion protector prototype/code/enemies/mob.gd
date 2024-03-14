extends CharacterBody2D
class_name Mob

var health
var speed
var damage
var player
var main
static var count = 0
var curent_count

# Called when the node enters the scene tree for the first time.
func _ready():
	count += 1
	curent_count = count
	player = get_node("/root/Main/PlayerObjects/Player")
	main = get_node("/root/Main")
	speed = 200
	health = 4
	damage = 2
		# create an animation type array and chose one randomly
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	# randi() % n selects a random integer between 0 and n-1
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	
	#var collision := move_and_collide(direction * delta)
	#if collision != null:
		#var body := collision.get_collider()
		#if (body.has_method("take_damage")):
			#body.take_damage(damage)
			#queue_free()

func enemy_take_damage(damage):
	health -= damage
	if(health <= 0):
		#enemy drops money on death
		const DROP = preload("res://code/other/money.tscn")
		var new_drop = DROP.instantiate()
		new_drop.global_position = %Marker2D.global_position
		self.main.add_child(new_drop)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func get_count():
	return curent_count

func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		area.take_damage(damage)
		await get_tree().create_timer(1).timeout
	elif area.is_in_group("base"):
		var name = area.get_name()  
		
		queue_free()
