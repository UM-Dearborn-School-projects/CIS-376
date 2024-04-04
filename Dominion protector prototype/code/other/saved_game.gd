class_name SavedGame
extends Resource

@export var player_position:Vector2
@export var player_health:float
@export var player_money:int
@export var player_speed:int

# section for saving weapons values
@export var player_sword: bool
@export var player_pistol: bool
@export var player_smg: bool
@export var player_duet: bool
@export var player_shotgun: bool
@export var player_sniper: bool
@export var player_rocket: bool

#array for saving cell positions
@export var cell_positions:Array[Vector2] = []
@export var cell_health:float


#array for saving towers? 
@export var tower_position:Array[Vector2] = []
@export var tower_health:float



