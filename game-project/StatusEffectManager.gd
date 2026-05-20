extends Node2D

var active_effects = {}

func add_status_effect(effect):
	var key = "effect_" + str(effect["source"])
	
	active_effects[key] = effect
	print(active_effects)
	
	if effect.has("duration"):
		get_tree().create_timer(effect["duration"]).timeout.connect(
			remove_status_effect.bind(key)
		)
		

func remove_status_effect(key):
	active_effects.erase(key)
	

func get_effects():
	var speed_modifiers = []
	var damage = 0
	var healing = 0
	
	for effects in active_effects.values():
		print(effects)
		if effects["type"] == "debuff":
			if effects["effect"] == "slow":
				speed_modifiers.append(2*effects["speed"])
				
	return speed_modifiers
