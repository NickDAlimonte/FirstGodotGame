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
	var applied = {}
	
	for effect in active_effects.values():
		var key = str(effect["spell_id"])

		if effect["stackable"] == 0:
			if applied.has(key) && applied[key]== true:
				continue
			applied[key] = true
		
		if effect["type"] == "debuff":
			if effect["effect"] == "slow":
				speed_modifiers.append(-effect["speed"])
				
	return speed_modifiers
