extends Node2D

var placing_tower = false
const Basic_Tower = preload("res://code/towers/BasicTower.tscn")

var placed_towers = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func reset():
	placing_tower = false
	for n in placed_towers:
		remove_child(n)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack") && placing_tower:
		var tower_node = Basic_Tower.instantiate()
		tower_node.position = get_global_mouse_position()
		add_child(tower_node)
		placed_towers.append(tower_node)
		placing_tower = false

func start_basic_tower_placement():
	placing_tower = true
