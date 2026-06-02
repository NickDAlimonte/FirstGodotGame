extends Node2D
var player

func _ready():
	var player_scene = preload("res://Player.tscn")
	player = player_scene.instantiate()
	player.position = Vector2(SaveData.PLAYER['pos_x'], SaveData.PLAYER['pos_y'])
	add_child(player)
