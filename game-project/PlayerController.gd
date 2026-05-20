extends CharacterBody2D

const base_speed = 300
@export var player_speed = base_speed
@export var player_health = 100
var active_effects = []

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * player_speed
	move_and_slide()
	

func take_damage(amount, source):
	player_health -= amount
	print("You took ", amount, " damage from ", source)
	if player_health <= 0:
		die()
	
func die():
	print("Player died")
	get_tree().quit()

func add_status_effect(effect):
	if !active_effects.has(effect) && !effect.has("stackable"):
		active_effects.append(effect)
		if effect.has("duration"):
			get_tree().create_timer(effect["duration"]).timeout.connect(remove_status_effect.bind(effect))
		update_speed()

func remove_status_effect(effect):
	active_effects.erase(effect)
	print('effect removed')
	update_speed()
	
func update_speed():
	var speed_mod = 0
	for effects in active_effects:
		if effects["type"] == "slow":
			speed_mod -= effects["speed"]
		elif effects["type"] == "boost":
			speed_mod+= effects["speed"]
	print(speed_mod)
	player_speed = base_speed + speed_mod
	if player_speed < 0:
		player_speed = 0
	
