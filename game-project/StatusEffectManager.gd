extends Node2D

var active_effects = {}

func add_status_effect(effect):
	var key = (str(effect["source"].get_instance_id()) + ":" + str(effect["aura_id"]))
	
	active_effects[key] = effect
	print(active_effects)
	
	if effect.has("debuff_duration"):
		get_tree().create_timer(effect["debuff_duration"]).timeout.connect(
			remove_status_effect.bind(key)
		)
		
func remove_status_effect(key):
	active_effects.erase(key)
	get_parent().update_stats()
	
func get_effects():
	var speed_modifiers = []
	var applied = {}
	
	for effect in active_effects.values():
		var key = str(effect["aura_id"])

		if effect["stackable"] == 0:
			if applied.has(key) && applied[key]== true:
				continue
			applied[key] = true
		
		if effect["type"] == "debuff":
			if effect.has("slow"):
				speed_modifiers.append(-effect["slow"])
				
	return speed_modifiers
