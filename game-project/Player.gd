extends Entity

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			var mouse_pos := get_global_mouse_position()
			cast_spell(1, mouse_pos)
			print("You cast Firewall")
			
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_pos := get_global_mouse_position()
			cast_spell(0, mouse_pos)
			print("You cast Blizzard")
