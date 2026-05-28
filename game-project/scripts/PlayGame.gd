extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_on_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_button_pressed():
	print("Starting game")
	var game_scene = preload("res://GameWorld.tscn")
	game_scene.instantiate()
	
	get_tree().change_scene_to_file("res://GameWorld.tscn")
